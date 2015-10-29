#include <iostream>
#include <string>
#include <stdio.h>
#include <mysql/mysql.h>

class sqlConnectionManager
{
public:
    const char *SERVER_NAME;
    const char *LOGIN;
    const char *PASSWORD;
    const char *DATABASE_NAME;
    unsigned int MYSQL_PORT_NUMBER;
    MYSQL *MYSQL_CONNECTION;
    
    void verifyUserLoginToDatabase (char username[], char password[]);
    bool verifyConnectionToDatabase();
    sqlConnectionManager();
};

 /* sqlConnectionManager_h */
