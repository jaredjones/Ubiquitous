//
//  Book.m
//  Exercise2Group7
//
//  Created by Jared Jones on 9/10/15.
//  Copyright © 2015 Jared Jones. All rights reserved.
//

#import "Book.h"

@implementation Book

- (instancetype) init{
    NSLog(@"Must instantiate using initWithStuff:");
    return nil;
}

- (instancetype) initWithStuff: (NSString *)isbn withTitle: (NSString *)title withAuthors: (NSString *)authors withCategory: (NSNumber *)category
{
    if ( self = [super init]){
        _isbn = isbn;
        _title = title;
        _authors = authors;
        _category = category;
        return self;
    }
    return nil;
}

+ (NSString *)getCategoryGivenID: (NSUInteger)num
{
    if (num == 0)
        return @"Programming";
    if (num == 1)
        return @"Science";
    if (num == 2)
        return @"Math";
    if (num == 3)
        return @"Fiction";

    return @"BAD BOY";
}

@end
