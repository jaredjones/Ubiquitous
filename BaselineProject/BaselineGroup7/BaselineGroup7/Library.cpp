//
//  Library.cpp
//  BaselineGroup7
//
//  Created by ubicomp7 on 8/27/15.
//  Copyright (c) 2015 ubicomp7. All rights reserved.
//

#include <iostream>
#include <vector>

#include "Library.h"

void Library::ImportBook(Book *book)
{
    this->bookList->push_back(book);
}

void Library::ImportStudent(Student *student)
{
    this->studentList->push_back(student);
}

void Library::displayAllBooksInSystem()
{
    std::list<Book *>::const_iterator iterator;
    for (iterator = this->bookList->begin(); iterator != this->bookList->end(); ++iterator) {
        std::cout << (*iterator)->getISBN() << " : " <<(*iterator)->getName() << std::endl;
    }
}

bool Library::studentExists(uint32_t id)
{
    std::list<Student *>::const_iterator iterator;
    for (iterator = this->studentList->begin(); iterator != this->studentList->end(); ++iterator) {
        std::string s = (*iterator)->getUID();
        uint32_t tmpID = std::stoi(s);
        if (tmpID == id)
            return true;
    }
    return false;
}

Book* Library::getBookByISBN(std::string isbn)
{
    std::list<Book *>::const_iterator iterator;
    for (iterator = this->bookList->begin(); iterator != this->bookList->end(); ++iterator) {
        
        if (isbn.compare((*iterator)->getISBN()) == 0)
            return (*iterator);
    }
    return nullptr;
}

Student* Library::getStudentByID(std::string studentID)
{
    std::list<Student *>::const_iterator iterator;
    for (iterator = this->studentList->begin(); iterator != this->studentList->end(); ++iterator) {
        
        if (studentID.compare((*iterator)->getUID()) == 0)
            return (*iterator);
    }
    return nullptr;
}

void Library::checkInBook(Book *book, Student *student)
{
    student->removeBook(book);
    book->setQuantity(book->getQuantity() + 1);
}

void Library::checkOutBook(Book *book, Student *student)
{
    student->addBook(book);
    book->setQuantity(book->getQuantity() - 1);
}