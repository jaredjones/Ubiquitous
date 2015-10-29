#ifndef SHARETHOUGHT_ACCOUNT_H
#define SHARETHOUGHT_ACCOUNT_H

class Account
{
        
public:
    std::string username;
    std::string password;
    Account(){
        this->username = "";
        this->password = "";
    }
    Account(std::string username, std::string password){
        this->username = username;
        this->password = password;
    }
};

#endif