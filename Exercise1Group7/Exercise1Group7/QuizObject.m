//
//  QuizObject.m
//  Exercise1Group7
//
//  Created by UH Game and Entrepreneurship on 9/3/15.
//  Copyright (c) 2015 ubicomp7. All rights reserved.
//

#import "QuizObject.h"

@interface QuizObject()

@end

@implementation QuizObject

- (instancetype)init{
    if (self = [super init]){
        return self;
    }
    return nil;
}

- (void) seedQuizWithValues: (NSString *)question withAnswer:(NSString *)answer withCategory: (NSNumber *)category{
    _question = question;
    _answer = answer;
    _category = category;
}

@end
