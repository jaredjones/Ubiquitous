//
//  Book.h
//  BaselineGroup7
//
//  Created by ubicomp7 on 8/27/15.
//  Copyright (c) 2015 ubicomp7. All rights reserved.
//

#ifndef __BaselineGroup7__Book__
#define __BaselineGroup7__Book__

#include <stdio.h>
#include <string>

class Book
{
private:
    std::string isbn;
    std::string bookName;
    uint32_t    quantity;
public:
    Book(std::string isbn, std::string bookName, uint32_t quantity)
    {
        this->isbn = isbn;
        this->bookName = bookName;
        this->quantity = quantity;
    }
    
    void setQuantity(uint32_t);
    uint32_t getQuantity();
    std::string getName();
    std::string getISBN();
};

#endif /* defined(__BaselineGroup7__Book__) */
