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

#include "config.h"
#include "timer.h"
#include "user.h"
#include "packet.h"

void WorldUpdateLoop();
void WorldUpdate(int timeDiff);

int serverSocket;
User* *connections;

int main(int argc, char **argv)
{
    printf("Done.\nCreating Socket Structures...\n");

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
                break;
            }
        }
        
        //uint64 finalSize;
        //char* packetData = ConstructPacket(SMSG_CONNECTED, 0, NULL, &finalSize);
        
        //send(clientID, packetData, finalSize, 0);
        //free(packetData);
    }
    
    //Check if there is any data to receive from
    for (int i = 0; i < SERVER_MAX_CONNECTIONS; i++)
    {
        if (connections[i] == nullptr)
            continue;
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
        switch(op.OPCODE)
        {
            case CMSG_KEEP_ALIVE:
                packetData = ConstructPacket(SMSG_KEEP_ALIVE, 0, NULL, &finalSize);
                send(connections[i]->SocketID, packetData, finalSize, NULL);
                break;
            default:
                printf("Bad Packet From Socket:%d", connections[i]->SocketID);
                break;
        }
        
    }
}