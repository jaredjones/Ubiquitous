#ifndef SHARETHOUGHT_USER_H
#define SHARETHOUGHT_USER_H

class User
{
        
public:
    int SocketID;
    double keepAliveEndPoint;
    bool klFlagged;
    User(){
        this->klFlagged = false;
        this->keepAliveEndPoint = 0.0;
    }
};

#endif