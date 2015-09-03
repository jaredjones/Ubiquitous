//
//  QuizObject.h
//  Exercise1Group7
//
//  Created by UH Game and Entrepreneurship on 9/3/15.
//  Copyright (c) 2015 ubicomp7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuizObject : NSObject

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) NSNumber *category;

- (void) seedQuizWithValues: (NSString *)question withAnswer:(NSString *)answer withCategory: (NSNumber *)category;

@end
