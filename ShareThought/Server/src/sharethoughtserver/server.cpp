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

int main(int argc, char **argv)
{
    printf("Done.\nCreating Socket Structures...\n");
    int sock;
    struct sockaddr_in serv_addr;
    struct sockaddr_in cli_addr;
    memset(&serv_addr, 0, sizeof(serv_addr));
    memset(&cli_addr, 0, sizeof(cli_addr));
    
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    serv_addr.sin_port = htons(BOUNDED_PORT);
    
    if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        printf("Failed to Create the Socket!\n");
        return 1;
    }
    printf("Done.\nSetting Socket Reusability...\n");
    int enable = 1;
    if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &enable, sizeof(int)) < 0)
    {
        perror("setsockopt(SO_REUSEADDR) failed!\n");
        return 1;
    }
    
    printf("Done.\nBinding to Configuration...\n");
    
    if ((bind(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr))) < 0)
    {
        printf("Failed to Bind to Port:%d\n", BOUNDED_PORT);
        perror("Binding Failed");
        return 1;
    }
    
    listen(sock, 1024);
    
    printf("Done.\nListening for Connections On: 0.0.0.0:%d\n", BOUNDED_PORT);
    
    //Sets non-blocking flag for accept, will inherit to children
    int flags = fcntl(sock, F_GETFL, 0);
    fcntl(sock, F_SETFL, flags | O_NONBLOCK);
    
    printf("\nServer has started up successfully!\n");
    printf("Waiting for Client Connections...\n");
    fflush(stdout);
    
    return 0;
}