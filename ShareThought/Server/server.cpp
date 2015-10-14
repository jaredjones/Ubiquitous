#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include <sys/socket.h>
#include <time.h>
#include <math.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include<ctime>
#include<cstring>
#include<netinet/in.h>
#include<netdb.h>
#include<list>
#include <fcntl.h>

const int PORT_NUM = 54312;
const int KEEP_ALIVE_TIMEOUT = 600;
#define MAX_CONNECTIONS 1024
#define BILLION 1000000000L

using namespace std;

struct Client
{
    int SocketID;
};

uint64_t TimeSpecToSeconds(struct timespec* ts)
{
    return ts->tv_sec + ts->tv_nsec / BILLION;
}



int main()
{
    int clientID = 0;
    char buffer[256];
    int sockID;
    int flagServer = 0;
    struct sockaddr_in sockInfo;
    struct timespec start, end;
    uint64_t diff;
    list<Client> clientSockets;
    memset(&sockInfo, 0 , sizeof(sockInfo));
    sockInfo.sin_family = AF_INET;
    sockInfo.sin_addr.s_addr = htonl(INADDR_ANY);
    sockInfo.sin_port = htons(PORT_NUM);
    //Client aClient;
    
    if((sockID = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        perror("Socket creation failed on server side.\n");
        return 1;
    }
    
    if((bind(sockID, (struct sockaddr *)&sockInfo, sizeof(sockInfo)) < 0))
    {
        perror("Binding socket on server has failed.\n");
        return 1;
    }
    
    listen(sockID, 1024);
    printf("Done.\nListening for Connections On: 0.0.0.0:%d\n", PORT_NUM);
    //clock_gettime(CLOCK_MONOTONIC, &start);
    
    while(1)
    {
        clientID = accept(sockID, (struct sockaddr*)NULL, NULL);
        if(clientID != -1)
        {
            int x = fcntl(clientID, F_GETFL, 0);
            fcntl(clientID, F_SETFL, F_GETFL, 0);
            bzero(buffer, 256);
            int c = read(clientID, buffer, 255);
            Client aClient;
            aClient.SocketID = clientID;
            clientSockets.push_back(aClient);
            printf("Connection made on: 0.0.0.0:%d\n", PORT_NUM);
        }
    }

    return 0;
}