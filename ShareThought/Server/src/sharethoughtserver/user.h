#ifndef SHARETHOUGHT_USER_H
#define SHARETHOUGHT_USER_H

#include <string>
#include <stdlib.h>

#include "account.h"

struct LoginPacketInfo
{
    std::string Username;
    std::string Password;
}LoginPacketInfo;

class User
{
        
public:
    int SocketID;
    double keepAliveEndPoint;
    bool klFlagged;
    Account account;
    User(){
        this->klFlagged = false;
        this->keepAliveEndPoint = 0.0;
    }
};

static struct LoginPacketInfo GetUserInfoGivenLoginPacketData(const char *pData)
{
    struct LoginPacketInfo lPInfo;
    
    uint8_t emailLength = *pData;
    char *email = (char*)malloc(emailLength + 1);
    memcpy(email, pData+1, emailLength);
    email[emailLength] = '\0';
    
    lPInfo.Username = std::string(email);
    free(email);
    
    uint8_t passwordLength = *(pData + emailLength + 1);
    char *password = (char*)malloc(passwordLength + 1);
    memcpy(password, pData+2+emailLength, passwordLength);
    password[passwordLength] = '\0';
    
    lPInfo.Password = std::string(password);
    free(password);

    return lPInfo;
}

#endif