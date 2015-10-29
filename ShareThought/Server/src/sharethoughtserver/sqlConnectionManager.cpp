#include "sqlConnectionManager.h"

sqlConnectionManager::sqlConnectionManager()
{
    SERVER_NAME = "gaea.uvora.com";
    LOGIN = "tdickson";
    PASSWORD = "Situs123!";
    DATABASE_NAME = "sharethought";
    MYSQL_PORT_NUMBER = 3306;
}


void sqlConnectionManager::verifyUserLoginToDatabase (char username[], char password[])
{
    
    
}

bool sqlConnectionManager::verifyConnectionToDatabase()
{
    //Set connection to null
    MYSQL_CONNECTION = mysql_init(NULL);
    
    //Establish SQL Connection
    if(!mysql_real_connect(MYSQL_CONNECTION, SERVER_NAME, LOGIN, PASSWORD, DATABASE_NAME, MYSQL_PORT_NUMBER, NULL, 0))
    {
        std::cout<<"CONNECTION TO DATABASE FAILED!\n";
        std::cout<<mysql_error(MYSQL_CONNECTION)<<std::endl;
        return false;
        
    }
    else
    {
        std::cout<<"CONNECTION TO DATABASE SUCCESS!\n";
        mysql_close(MYSQL_CONNECTION);
        return true;
    }
}