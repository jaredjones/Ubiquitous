//
//  Library.h
//  BaselineGroup7
//
//  Created by ubicomp7 on 8/27/15.
//  Copyright (c) 2015 ubicomp7. All rights reserved.
//

#ifndef __BaselineGroup7__Library__
#define __BaselineGroup7__Library__

#include <stdio.h>
#include <list>

#include "Book.h"
#include "Student.h"

class Library
{
public:
    std::list<Book *> *bookList;
    std::list<Student *> *studentList;
    
    void ImportBook(Book *book);
    void ImportStudent(Student *student);
    void displayAllBooksInSystem();
    bool studentExists(uint32_t id);
    void checkInBook(Book *book, Student *student);
    void checkOutBook(Book *book, Student *student);
    Book* getBookByISBN(std::string isbn);
    Student* getStudentByID(std::string studentID);
    
    Library()
    {
        this->bookList = new std::list<Book *>();
        this->studentList = new std::list<Student *>();
    }
    
    ~Library()
    {
        delete bookList;
        delete studentList;
    }
};

#endif /* defined(__BaselineGroup7__Library__) */
