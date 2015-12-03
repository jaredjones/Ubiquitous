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
    char *profilePic;
    uint32_t profilePicLen;
    uint32_t profilePicCurLen;
    Account(){
        this->username = "";
        this->password = "";
        this->email = "";
        this->fname = "";
        this->lname = "";
        this->aboutMe = "";
        this->profilePic = nullptr;
        this->profilePicLen = 0;
        this->profilePicCurLen = 0;
    }
    Account(std::string username, std::string password, std::string email, std::string fname, std::string lname, std::string aboutMe){
        this->username = username;
        this->password = password;
        this->email = email;
        this->fname = fname;
        this->lname = lname;
        this->aboutMe = aboutMe;
        this->profilePic = nullptr;
        this->profilePicLen = 0;
        this->profilePicCurLen = 0;
    }
    
    ~Account(){
        printf("Account Deallocating\n");
        if (profilePic != nullptr){
            free (profilePic);
            profilePic = nullptr;
            this->profilePicLen = 0;
            this->profilePicCurLen = 0;
        }
    }
};

#endif