#ifndef SHARETHOUGHT_USER_H
#define SHARETHOUGHT_USER_H

#include <string>
#include <stdlib.h>

#include "account.h"

struct LoginRegistrationPacketInfo
{
    std::string Username = "";
    std::string Password = "";
    std::string FirstName = "";
    std::string LastName = "";
    std::string Email = "";
    std::string AboutUs = "";
}LoginRegistrationPacketInfo;

class User
{
        
public:
    int SocketID;
    double keepAliveEndPoint;
    bool klFlagged;
    Account *account = nullptr;
    std::string SSO;
    User(){
        this->klFlagged = false;
        this->keepAliveEndPoint = 0.0;
    }
};

static struct LoginRegistrationPacketInfo GetUserInfoGivenLoginPacketData(const char *pData)
{
    struct LoginRegistrationPacketInfo lPInfo;
    
    uint8_t usernameLength = *pData;
    char *username = (char*)malloc(usernameLength + 1);
    memcpy(username, pData+1, usernameLength);
    username[usernameLength] = '\0';
    
    lPInfo.Username = std::string(username);
    free(username);
    
    uint8_t passwordLength = *(pData + usernameLength + 1);
    char *password = (char*)malloc(passwordLength + 1);
    memcpy(password, pData+2+usernameLength, passwordLength);
    password[passwordLength] = '\0';
    
    lPInfo.Password = std::string(password);
    free(password);

    return lPInfo;
}
static struct LoginRegistrationPacketInfo GetUserInfoGivenRegistrationPacketData(const char *pData){
    struct LoginRegistrationPacketInfo lPInfo;
    
    
    uint16_t emailLength = *pData;
    uint16_t passwordLength = *(pData + emailLength + 1);
    uint16_t firstNameLength = *(pData + emailLength + passwordLength + 2);
    uint16_t lastNameLength = *(pData + emailLength + passwordLength + firstNameLength + 3);
    uint16_t aboutMeLength = *(pData + emailLength + passwordLength + firstNameLength + lastNameLength + 4);
    uint16_t usernameLength = *(pData + emailLength + passwordLength + firstNameLength + lastNameLength + aboutMeLength + 5);
    
    char *email = (char*)malloc(emailLength + 1);
    memcpy(email, pData+1, emailLength);
    email[emailLength] = '\0';
    
    lPInfo.Email = std::string(email);
    free(email);
    
    
    char *password = (char*)malloc(passwordLength + 1);
    memcpy(password, pData+2+emailLength, passwordLength);
    password[passwordLength] = '\0';
    
    lPInfo.Password = std::string(password);
    free(password);
    
    char *fname = (char*)malloc(firstNameLength + 1);
    memcpy(fname, pData + emailLength + passwordLength + 3, firstNameLength);
    fname[firstNameLength] = '\0';
    
    lPInfo.FirstName = std::string(fname);
    free(fname);
    
    char *lname = (char*)malloc(lastNameLength + 1);
    memcpy(lname, pData + emailLength + passwordLength + firstNameLength + 4, lastNameLength);
    lname[lastNameLength] = '\0';
    
    lPInfo.LastName = std::string(lname);
    free(lname);
    
    char *aboutMe = (char*)malloc(aboutMeLength + 1);
    memcpy(aboutMe, pData + emailLength + passwordLength + firstNameLength + lastNameLength + 5, aboutMeLength);
    aboutMe[aboutMeLength] = '\0';
    
    lPInfo.AboutUs = std::string(aboutMe);
    free(aboutMe);
    
    char *username = (char*)malloc(usernameLength + 1);
    memcpy(username, pData + emailLength + passwordLength + firstNameLength + lastNameLength + aboutMeLength + 6, usernameLength);
    username[usernameLength] = '\0';
    
    lPInfo.Username = std::string(username);
    free(username);
    
    return lPInfo;
}


#endif