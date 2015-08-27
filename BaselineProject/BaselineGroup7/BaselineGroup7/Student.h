//
//  Student.h
//  BaselineGroup7
//
//  Created by ubicomp7 on 8/27/15.
//  Copyright (c) 2015 ubicomp7. All rights reserved.
//

#ifndef __BaselineGroup7__Student__
#define __BaselineGroup7__Student__

#include <stdio.h>
#include <string>

class Student
{
private:
    std::string uid;
    std::string name;
public:
    Student(std::string uid, std::string fullName)
    {
        this->uid = uid;
        this->name = fullName;
    }
    
    std::string getName()
    {
        return this->name;
    }
    
    std::string getUID()
    {
        return this->uid;
    }
};


#endif /* defined(__BaselineGroup7__Student__) */
