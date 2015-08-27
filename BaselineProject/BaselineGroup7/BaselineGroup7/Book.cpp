//
//  Book.cpp
//  BaselineGroup7
//
//  Created by ubicomp7 on 8/27/15.
//  Copyright (c) 2015 ubicomp7. All rights reserved.
//

#include "Book.h"

void Book::setQuantity(uint32_t quantity)
{
    this->quantity = quantity;
}

std::string Book::getName()
{
    return this->bookName;
}

std::string Book::getISBN()
{
    return this->isbn;
}