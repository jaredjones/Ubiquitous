#include "SQLConnectionManager.h"

SQLConnectionManager* SQLConnectionManager::getInstance()
{
    static SQLConnectionManager *sqlMgr = new SQLConnectionManager();
    return sqlMgr;
}

SQLConnectionManager::SQLConnectionManager()
{
    SERVER_NAME = "gaea.uvora.com";
    LOGIN = "tdickson";
    PASSWORD = "Situs123!";
    DATABASE_NAME = "sharethought";
    MYSQL_PORT_NUMBER = 3306;
}

bool SQLConnectionManager::ConnectToDatabase()
{
    try {
        driver = get_driver_instance();
        std::string s = "tcp://";
        s+=  SERVER_NAME;
        s+= ":";
        s+= MYSQL_PORT_NUMBER;
        
        conn = driver->connect(s.c_str(), LOGIN, PASSWORD);
        
        conn->setSchema(DATABASE_NAME);
        
    } catch (sql::SQLException &e) {
        /*
         MySQL Connector/C++ throws three different exceptions:
         
         - sql::MethodNotImplementedException (derived from sql::SQLException)
         - sql::InvalidArgumentException (derived from sql::SQLException)
         - sql::SQLException (derived from std::runtime_error)
         */
        std::cout << "# ERR: SQLException in " << __FILE__;
        std::cout << "(" << __FUNCTION__ << ") on line " << __LINE__ << std::endl;
        /* what() (derived from std::runtime_error) fetches error message */
        std::cout << "# ERR: " << e.what();
        std::cout << " (MySQL error code: " << e.getErrorCode();
        std::cout << ", SQLState: " << e.getSQLState() << " )" << std::endl;
        
        return EXIT_FAILURE;
    }
    std::cout << "Connection to Database Successful!" << std::endl;
    return true;
}