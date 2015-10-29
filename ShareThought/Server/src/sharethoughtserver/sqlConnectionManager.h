#ifndef _H_SQL_CONNECTION_MANAGER
#define _H_SQL_CONNECTION_MANAGER

#include <iostream>
#include <string>
#include <stdio.h>
#include <mysql/mysql.h>

class SqlConnectionManager
{
public:
    static SqlConnectionManager* getInstance();
    
    const char *SERVER_NAME;
    const char *LOGIN;
    const char *PASSWORD;
    const char *DATABASE_NAME;
    unsigned int MYSQL_PORT_NUMBER;
    MYSQL *MYSQL_CONNECTION;
    
    bool ConnectToDatabase();
    
private:
    SqlConnectionManager();
};

 /* sqlConnectionManager_h */
#endif