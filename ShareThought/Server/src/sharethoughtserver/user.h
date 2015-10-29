#ifndef SHARETHOUGHT_USER_H
#define SHARETHOUGHT_USER_H

#include <string>
#include <stdlib.h>

#include "account.h"

struct LoginRegistrationPacketInfo
{
    std::string Username;
    std::string Password;
    std::string FirstName;
    std::string LastName;
    std::string AboutUs;
}LoginRegistrationPacketInfo;

class User
{
        
public:
    int SocketID;
    double keepAliveEndPoint;
    bool klFlagged;
    Account *account = nullptr;
    User(){
        this->klFlagged = false;
        this->keepAliveEndPoint = 0.0;
    }
};

static struct LoginRegistrationPacketInfo GetUserInfoGivenLoginPacketData(const char *pData)
{
    struct LoginRegistrationPacketInfo lPInfo;
    
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
static struct LoginRegistrationPacketInfo GetUserInfoGivenRegistrationPacketData(const char *pData){
    struct LoginRegistrationPacketInfo lPInfo = GetUserInfoGivenLoginPacketData(pData);
    uint8_t emailLength = *pData;
    uint8_t passwordLength = *(pData + emailLength + 1);
    uint8_t firstNameLength = *(pData + emailLength + passwordLength + 2);
    uint8_t lastNameLength = *(pData + emailLength + passwordLength + firstNameLength + 3);
    uint8_t aboutMeLength = *(pData + emailLength + passwordLength + firstNameLength + lastNameLength + 4);
    
    char *fname = (char*)malloc(firstNameLength + 1);
    memcpy(fname, pData + 1 + emailLength + 1 + passwordLength + 1, firstNameLength);
    fname[firstNameLength] = '\0';
    
    lPInfo.FirstName = std::string(fname);
    free(fname);
    
    char *lname = (char*)malloc(lastNameLength + 1);
    memcpy(lname, pData + 1 + emailLength + 1 + passwordLength + 1 + lastNameLength + 1, lastNameLength);
    lname[lastNameLength] = '\0';
    
    lPInfo.LastName = std::string(lname);
    free(lname);
    
    char *aboutMe = (char*)malloc(aboutMeLength + 1);
    memcpy(aboutMe, pData + 1 + emailLength + 1 + passwordLength + 1 + lastNameLength + 1 + aboutMeLength + 1, aboutMeLength);
    aboutMe[aboutMeLength] = '\0';
    
    lPInfo.AboutUs = std::string(aboutMe);
    free(aboutMe);
    
    
    
    return lPInfo;
}


#endif