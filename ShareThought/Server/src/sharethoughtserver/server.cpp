#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <time.h>
#include <math.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <ctime>
#include <cstring>
#include <netinet/in.h>
#include <netdb.h>
#include <list>
#include <fcntl.h>

#include <thread>
#include <unordered_map>

#include "Common.h"
#include "Config.h"
#include "Timer.h"
#include "User.h"
#include "Packet.h"

//#include <mysql/mysql.h>
#include "SQLConnectionManager.h"

void WorldUpdateLoop();
void WorldUpdate(int timeDiff);

int serverSocket;
User* *connections;


int main(int argc, char **argv)
{
    struct sockaddr_in serv_addr;
    struct sockaddr_in cli_addr;
    memset(&serv_addr, 0, sizeof(serv_addr));
    memset(&cli_addr, 0, sizeof(cli_addr));
    
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    serv_addr.sin_port = htons(SERVER_PORT);
    
    if ((serverSocket = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        printf("Failed to Create the Socket!\n");
        return 1;
    }
    
    printf("Done.\nSetting Socket Reusability...\n");
    int enable = 1;
    if (setsockopt(serverSocket, SOL_SOCKET, SO_REUSEADDR, &enable, sizeof(int)) < 0)
    {
        perror("setsockopt(SO_REUSEADDR) failed!\n");
        return 1;
    }
    
    printf("Done.\nBinding to Configuration...\n");
    
    if ((bind(serverSocket, (struct sockaddr *)&serv_addr, sizeof(serv_addr))) < 0)
    {
        printf("Failed to Bind to Port:%d\n", SERVER_PORT);
        perror("Binding Failed");
        return 1;
    }
    
    listen(serverSocket, SERVER_CONNECTION_MAX_QUEUE);
    
    printf("Done.\nListening for Connections On: 0.0.0.0:%d\n", SERVER_PORT);
    
    //Sets non-blocking flag for accept, will inherit to children
    int flags = fcntl(serverSocket, F_GETFL, 0);
    fcntl(serverSocket, F_SETFL, flags | O_NONBLOCK);
    
    printf("\nServer has started up successfully!\n");
    printf("Waiting for Client Connections...\n");
    fflush(stdout);
    
    connections = new User*[SERVER_MAX_CONNECTIONS];
    for (int i = 0; i < SERVER_MAX_CONNECTIONS; i++)
    {
        connections[i] = nullptr;
    }
    
    //Initalize and Connect to Database
    
    if (!SQLMGR->ConnectToDatabase())
    {
        printf("Unable to Connect to the MariaDB Database!\n");
        return 1;
    }
    
    //Program Loop
    WorldUpdateLoop();
    
    delete []connections;
    
    return 0;
}


bool isRunning = true;
void WorldUpdateLoop()
{
    uint64 realCurrTime = 0;
    uint64 realPrevTime = getMSTime();
    
    uint64 prevSleepTime = 0;// used for balanced full tick time length near WORLD_SLEEP_CONST
    
    while (isRunning)
    {
        //++World::m_worldLoopCounter;
        realCurrTime = getMSTime();
        
        uint64 diff = getMSTimeDiff(realPrevTime, realCurrTime);
        
        WorldUpdate(diff);
        realPrevTime = realCurrTime;
        
        if ( diff <= WORLD_SLEEP_CONST + prevSleepTime)
        {
            prevSleepTime = WORLD_SLEEP_CONST + prevSleepTime - diff;
            std::this_thread::sleep_for(std::chrono::milliseconds(prevSleepTime));
        }
        else
            prevSleepTime = 0;
    }
}

void WorldUpdate(int timeDiff)
{
    //Check Keep Alives
    auto now = std::chrono::steady_clock::now().time_since_epoch();
    auto currentTimeSinceEpoch = std::chrono::duration_cast<std::chrono::milliseconds>(now).count();
    
    //Make sure MySQL is alive
    if (SQLMGR->conn->isClosed() || !SQLMGR->conn->isValid()){
        SQLMGR->conn->reconnect();
    }
    
    int clientID = accept(serverSocket, (struct sockaddr *)NULL, NULL);
    if (clientID != -1)
    {
        int flags = fcntl(clientID, F_GETFL, 0);
        fcntl(clientID, F_SETFL, flags | O_NONBLOCK);
        
        for (int i = 0; i < SERVER_MAX_CONNECTIONS; i++)
        {
            if (connections[i] == nullptr)
            {
                connections[i] = new User();
                connections[i]->SocketID = clientID;
                printf("Connection[%d] Created : Using Socket ID:%d\n", i, clientID);
                
                uint64 finalSize;
                char *packet = ConstructPacket(SMSG_CONNECTED, 0, NULL, &finalSize);
                send(connections[i]->SocketID, packet, finalSize, NULL);
                free(packet);
                
                auto now = std::chrono::steady_clock::now().time_since_epoch();
                double kLEndPoint = (double)std::chrono::duration_cast<std::chrono::milliseconds>(now).count();
                connections[i]->keepAliveEndPoint = kLEndPoint + 5000.0;
                
                break;
            }
        }
    }
    
    //Check if there is any data to receive from
    for (int i = 0; i < SERVER_MAX_CONNECTIONS; i++)
    {
        if (connections[i] == nullptr)
            continue;
        
        if (currentTimeSinceEpoch >= connections[i]->keepAliveEndPoint)
        {
            if (connections[i]->klFlagged)
            {
                shutdown(connections[i]->SocketID, SHUT_RDWR);
                close(connections[i]->SocketID);
                delete connections[i]->account;
                delete connections[i];
                connections[i] = nullptr;
                continue;
            }
            connections[i]->klFlagged = true;
            uint64 finalSize;
            char *packetData;
            packetData = ConstructPacket(SMSG_KEEP_ALIVE, 0, NULL, &finalSize);
            send(connections[i]->SocketID, packetData, finalSize, NULL);
            free(packetData);
            connections[i]->keepAliveEndPoint = currentTimeSinceEpoch + 5000;
        }
        
        char buffer[1024];
        int64 retSize = recv(connections[i]->SocketID, &buffer, sizeof(buffer), 0);
        
        //No data in buffer so ignore
        if (retSize <= 0)
            continue;
        
        Packet op = DecodePacket(buffer, sizeof(buffer));
        if (op.OPCODE == 0x00)
            continue;
        
        uint64 finalSize;
        char *packetData;
        struct LoginRegistrationPacketInfo lpInfo;
        
        switch(op.OPCODE)
        {
            case CMSG_REGISTER:
                printf("CMSG_REGISTER\n");
                if (connections[i]->account == nullptr){
                    lpInfo = GetUserInfoGivenRegistrationPacketData(op.DATA);
                    
                    std::string hashedPass = LOGIN_HASH_SALT_SHAKER;
                    hashedPass += lpInfo.Password;
                    char *finalMD5 = str2md5(hashedPass.c_str(), hashedPass.length());
                    lpInfo.Password = std::string(finalMD5);
                    free(finalMD5);
                    
                    try {
                        sql::PreparedStatement *pstmt;
                        
                        pstmt = SQLMGR->conn->prepareStatement("SELECT * FROM User WHERE USERNAME = ?");
                        pstmt->setString(1, lpInfo.Username);
                        sql::ResultSet *resultSet = pstmt->executeQuery();
                        
                        if (resultSet->rowsCount() > 0){
                            printf("SMSG_ACCOUNT_ALREADY_EXISTS\n");
                            packetData = ConstructPacket(SMSG_ACCOUNT_ALREADY_EXISTS, 0, NULL, &finalSize);
                            send(connections[i]->SocketID, packetData, finalSize, 0);
                            free(packetData);
                            delete pstmt;
                            delete resultSet;
                            return;
                        }
                        
                        pstmt = SQLMGR->conn->prepareStatement("INSERT INTO User (USERNAME, PASSWORD, EMAIL, FIRST_NAME, LAST_NAME, ABOUT_ME) VALUES (?,?,?,?,?,?)");
                        pstmt->setString(1, lpInfo.Username);
                        pstmt->setString(2, lpInfo.Password);
                        pstmt->setString(3, lpInfo.Email);
                        pstmt->setString(4, lpInfo.FirstName);
                        pstmt->setString(5, lpInfo.LastName);
                        pstmt->setString(6, lpInfo.AboutUs);
                        pstmt->execute();
                        delete pstmt;
                        delete resultSet;
                    } catch (sql::SQLException &e) {
                        std::cout << "# ERR: SQLException in " << __FILE__;
                        std::cout << "(" << __FUNCTION__ << ") on line " << __LINE__ << std::endl;
                        /* what() (derived from std::runtime_error) fetches error message */
                        std::cout << "# ERR: " << e.what();
                        std::cout << " (MySQL error code: " << e.getErrorCode();
                        std::cout << ", SQLState: " << e.getSQLState() << " )" << std::endl;
                        
                        return;
                    }
                    
                    packetData = ConstructPacket(SMSG_ACCOUNT_CREATED, 0, NULL, &finalSize);
                    send(connections[i]->SocketID, packetData, finalSize, 0);
                    free(packetData);
                }
                
                break;
            case CMSG_KEEP_ALIVE:
                printf("CMSG_KEEP_ALIVE\n");
                connections[i]->klFlagged = false;
                break;
            case CMSG_LOGIN:
                printf("CMSG_LOGIN\n");
                if (connections[i]->account == nullptr){
                    lpInfo = GetUserInfoGivenLoginPacketData(op.DATA);
                    try {
                        sql::PreparedStatement *pstmt;
                        
                        pstmt = SQLMGR->conn->prepareStatement("SELECT * FROM User WHERE USERNAME = ? AND PASSWORD = ?");
                        
                        std::string hashedPass = LOGIN_HASH_SALT_SHAKER;
                        hashedPass += lpInfo.Password;
                        char *finalMD5 = str2md5(hashedPass.c_str(), hashedPass.length());
                        lpInfo.Password = std::string(finalMD5);
                        free(finalMD5);
                        
                        pstmt->setString(1, lpInfo.Username);
                        pstmt->setString(2, lpInfo.Password);
                        sql::ResultSet *resultSet = pstmt->executeQuery();
                        
                        if (resultSet->rowsCount() > 0){
                            char *guid = generateguid();
                            resultSet->first();
                            
                            connections[i]->account = new Account(resultSet->getString("USERNAME"),
                                                                  resultSet->getString("PASSWORD"),
                                                                  resultSet->getString("EMAIL"),
                                                                  resultSet->getString("FIRST_NAME"),
                                                                  resultSet->getString("LAST_NAME"),
                                                                  resultSet->getString("ABOUT_ME"));
                            connections[i]->SSO = std::string(guid);
                            delete(pstmt);
                            pstmt = SQLMGR->conn->prepareStatement("UPDATE User SET SSO = ? WHERE USER_ID = ?");
                            pstmt->setString(1, connections[i]->SSO);
                            pstmt->setString(2, resultSet->getString("USER_ID"));
                            pstmt->execute();
                            
                            char buf[1024];
                            sprintf(buf, "%c%s%c%s%c%s%c%s%c%s%c%s",
                                    (char)strlen(guid), guid,
                            (char)connections[i]->account->username.length(), connections[i]->account->username.c_str(),
                            (char)connections[i]->account->email.length(), connections[i]->account->email.c_str(),
                            (char)connections[i]->account->fname.length(), connections[i]->account->fname.c_str(),
                            (char)connections[i]->account->lname.length(), connections[i]->account->lname.c_str(),
                            (char)connections[i]->account->aboutMe.length(), connections[i]->account->aboutMe.c_str());
                            
                            packetData = ConstructPacket(SMSG_SUCCESSFUL_LOGIN, (uint16_t)strlen(buf), buf, &finalSize);
                            send(connections[i]->SocketID, packetData, finalSize, 0);
                            free(guid);
                            free(packetData);
                            delete pstmt;
                            delete resultSet;
                            return;
                        }else{
                            packetData = ConstructPacket(SMSG_UNSUCCESSFUL_LOGIN, 0, NULL, &finalSize);
                            send(connections[i]->SocketID, packetData, finalSize, 0);
                            free(packetData);
                            delete pstmt;
                            delete resultSet;
                            return;
                        }
                        delete pstmt;
                        delete resultSet;
                    } catch (sql::SQLException &e) {
                        std::cout << "# ERR: SQLException in " << __FILE__;
                        std::cout << "(" << __FUNCTION__ << ") on line " << __LINE__ << std::endl;
                        /* what() (derived from std::runtime_error) fetches error message */
                        std::cout << "# ERR: " << e.what();
                        std::cout << " (MySQL error code: " << e.getErrorCode();
                        std::cout << ", SQLState: " << e.getSQLState() << " )" << std::endl;
                        
                        return;
                    }
                }
                break;
            case CMSG_LOGOUT:
                printf("CMSG_LOGOUT\n");
                delete connections[i]->account;
                connections[i]->account = nullptr;
                break;
            default:
                printf("Bad Packet:%d From Socket:%d\n", op.OPCODE, connections[i]->SocketID);
                break;
        }
        
    }
}