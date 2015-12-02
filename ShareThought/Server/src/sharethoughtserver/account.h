#ifndef SHARETHOUGHT_ACCOUNT_H
#define SHARETHOUGHT_ACCOUNT_H

class Account
{
        
public:
    std::string username;
    std::string password;
    std::string email;
    std::string fname;
    std::string lname;
    std::string aboutMe;
    Account(){
        this->username = "";
        this->password = "";
        this->email = "";
        this->fname = "";
        this->lname = "";
        this->aboutMe = "";
    }
    Account(std::string username, std::string password, std::string email, std::string fname, std::string lname, std::string aboutMe){
        this->username = username;
        this->password = password;
        this->email = email;
        this->fname = fname;
        this->lname = lname;
        this->aboutMe = aboutMe;
    }
};

#endif