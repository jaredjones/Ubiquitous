//
//  QuizManager.h
//  Exercise1Group7
//
//  Created by UH Game and Entrepreneurship on 9/3/15.
//  Copyright (c) 2015 ubicomp7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuizManager.h"
#import "QuizObject.h"


@interface QuizManager : NSObject

- (void)createQuizObjects;
- (QuizObject *)grabRandomQuestionGivenCategory: (NSNumber *)category withPriorQuestion:(QuizObject* )lastQuestion;

@end
