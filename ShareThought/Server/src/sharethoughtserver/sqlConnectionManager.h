#ifndef _H_SQL_CONNECTION_MANAGER
#define _H_SQL_CONNECTION_MANAGER

#include <mysql_driver.h>
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>
#include <cppconn/prepared_statement.h>

#include <iostream>
#include <string>
#include <stdio.h>

#define SQLMGR SQLConnectionManager::getInstance()

class SQLConnectionManager
{
public:
    static SQLConnectionManager* getInstance();
    
    const char *SERVER_NAME;
    const char *LOGIN;
    const char *PASSWORD;
    const char *DATABASE_NAME;
    unsigned int MYSQL_PORT_NUMBER;
    sql::Driver *driver;
    sql::Connection *conn;
    
    bool ConnectToDatabase();
    void SQL_RegisterAccount(std::string email,
                             std::string password,
                             std::string firstName,
                             std::string lastName,
                             std::string username,
                             std::string about);
    
private:
    SQLConnectionManager();
};
 /* sqlConnectionManager_h */
#endif