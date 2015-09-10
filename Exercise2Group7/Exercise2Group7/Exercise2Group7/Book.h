//
//  Book.h
//  Exercise2Group7
//
//  Created by Jared Jones on 9/10/15.
//  Copyright © 2015 Jared Jones. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, strong) NSString *isbn;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *authors;
@property (nonatomic, strong) NSNumber *category;

- (instancetype) initWithStuff: (NSString *)isbn withTitle: (NSString *)title withAuthors: (NSString *)authors withCategory: (NSNumber *)category;

@end
