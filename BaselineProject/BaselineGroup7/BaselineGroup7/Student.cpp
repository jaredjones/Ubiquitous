//
//  Student.cpp
//  BaselineGroup7
//
//  Created by ubicomp7 on 8/27/15.
//  Copyright (c) 2015 ubicomp7. All rights reserved.
//

#include <string>
#include <iostream>
#include "Student.h"
#include "Book.h"

void Student::addBook(Book *b)
{
    bookList.push_back(b);
}

void Student::removeBook(Book *b)
{
    bookList.remove(b);
}

void Student::printBookList()
{
    std::list<Book *>::const_iterator iterator;
    std::cout << this->name << std::endl;
    
    for (iterator = this->bookList.begin(); iterator != this->bookList.end(); ++iterator) {
        std::cout << "    " << (*iterator)->getISBN() << " : " <<(*iterator)->getName() << std::endl;
    }
}

bool Student::hasBook(Book *b)
{
    std::list<Book *>::const_iterator iterator;
    std::cout << this->name << std::endl;
    
    for (iterator = this->bookList.begin(); iterator != this->bookList.end(); ++iterator) {
        if (b == *(iterator))
            return true;
    }
    return false;
}