//  BaselineGroup7

//  Jared Jones         1386891
//  Faysal Sharif       1168315
//  Timothy Dickson     1204910
//  Stefan Theard       1208198
//  Aidaly Santamaria   1184717

#include <iostream>
#include <string>
#include <fstream>

#include "Library.h"
#include "Book.h"
#include "Student.h"

Library *library = nullptr;

//Function Prototypes
bool populateBooks();
bool populateStudents();

int main(int argc, const char * argv[])
{
    library = new Library();
    
    populateBooks();
    populateStudents();
    
    int option = 0;
    do
    {
        std::cout << "#################################" << std::endl;
        std::cout << "# Welcome to the Library System #" << std::endl;
        std::cout << "#################################" << std::endl << std::endl;
        
        std::cout << "1) Display All Books" << std::endl;
        std::cout << "2) Check In Book" << std::endl;
        std::cout << "3) Check Out Book" << std::endl;
        std::cout << "4) Display Checked Out Books for all Students" << std::endl;
        std::cout << "5) Close Program" << std::endl;
        
        std::cin >> option;
        
        std::string studentID;
        std::string tmpISBN;
        switch (option)
        {
            case 0:
                continue;
            case 1:
                library->displayAllBooksInSystem();
                break;
            case 2:
                
                std::cout << std::endl << "Please Enter Your Student ID:";
                std::cin >> studentID;
                
                if (!library->studentExists(std::stoi(studentID)))
                {
                    std::cout << "The student you entered doesn't exist!" << std::endl;
                    break;
                }
                
                library->displayAllBooksInSystem();
                std::cout << std::endl << "Enter the ISBN To Check In a Book:";
                
                std::cin >> tmpISBN;
                
                //TODO: Should check if ISBN IS VALID
                library->checkInBook(library->getBookByISBN(tmpISBN), library->getStudentByID(studentID));
                
                std::cout << "The book has been checked in!" << std::endl;
                
                break;
            case 3:
                break;
            case 4:
                break;
            case 5:
                break;
        }
        
    } while (option != 5);
    
    delete library;
    return 0;
}

bool populateBooks()
{
    std::ifstream input;
    
    input.open("books.txt");
    if (!input.is_open())
    {
        std::cout << "Cannot open the books.txt file" << std::endl;
        return false;
    }
    
    while (!input.eof())
    {
        std::string line;
        std::getline(input, line);
        
        int counter = 0;
        std::string isbn;
        std::string bookName;
        std::string quantity;
        
        char *pch = std::strtok((char*)line.c_str(), ",");
        while (pch != NULL)
        {
            if (counter == 0)
                isbn = pch;
            else if (counter == 1)
                bookName = pch;
            else if (counter == 2)
            {
                quantity = pch;
                Book *book = new Book(isbn, bookName, std::stoi(quantity));
                library->ImportBook(book);
            }
            
            pch = strtok(NULL, ",");
            ++counter;
        }
    }
    return true;
}

bool populateStudents()
{
    std::ifstream input;
    
    input.open("students.txt");
    if (!input.is_open())
    {
        std::cout << "Cannot open the students.txt file" << std::endl;
        return false;
    }
    
    while (!input.eof())
    {
        std::string line;
        std::getline(input, line);
        
        int counter = 0;
        
        std::string uid;
        std::string fullName;
        
        char *pch = std::strtok((char*)line.c_str(), ",");
        while (pch != NULL)
        {
            if (counter == 0)
                uid = pch;
            else if (counter == 1)
            {
                fullName = pch;
            
                Student *student = new Student(uid, fullName);
                library->ImportStudent(student);
            }
            
            pch = strtok(NULL, ",");
            ++counter;
        }
    }
    return true;
}
