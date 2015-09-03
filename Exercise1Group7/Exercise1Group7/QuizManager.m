//
//  QuizManager.m
//  Exercise1Group7
//
//  Created by UH Game and Entrepreneurship on 9/3/15.
//  Copyright (c) 2015 ubicomp7. All rights reserved.
//

#import "QuizManager.h"
#import "QuizObject.h"

@interface QuizManager ()

@property (nonatomic, strong) NSMutableArray *quizContainer;

@end

@implementation QuizManager

- (instancetype)init{
    if (self = [super init]){
        _quizContainer = [[NSMutableArray alloc]init];
        return self;
    }
    return nil;
}

- (void)createQuizObjects{
    
    QuizObject *q1 = [[QuizObject alloc]init];
    [q1 seedQuizWithValues:@"What is the super class for a Cocoa object?" withAnswer:@"NSObject" withCategory:[NSNumber numberWithInteger:0]];
    [_quizContainer addObject: q1];
    
    QuizObject *q2 = [[QuizObject alloc]init];
    [q2 seedQuizWithValues:@"What code do you type to initalize a string object with a null terminated C-String?" withAnswer:@"NSString *myString = [[NSString alloc] initWithString:@\"\"];" withCategory:[NSNumber numberWithInteger:0]];
    [_quizContainer addObject: q2];
    
    QuizObject *q3 = [[QuizObject alloc]init];
    [q3 seedQuizWithValues:@"What is the time complexity of accessing an element in a singly linked list?" withAnswer:@"O(n)" withCategory:[NSNumber numberWithInteger:1]];
    [_quizContainer addObject: q3];
    
    QuizObject *q4 = [[QuizObject alloc]init];
    [q4 seedQuizWithValues:@"What is the time complexity of quicksort in its worse case?" withAnswer:@"O(n^2)" withCategory:[NSNumber numberWithInteger:1]];
    [_quizContainer addObject: q4];
    
    QuizObject *q5 = [[QuizObject alloc]init];
    [q5 seedQuizWithValues:@"How do you calculate variance given expected value?" withAnswer:@"Variance = E[X^2] - (E[X])^2" withCategory:[NSNumber numberWithInteger:2]];
    [_quizContainer addObject: q5];
    
    QuizObject *q6 = [[QuizObject alloc]init];
    [q6 seedQuizWithValues:@"Does P = NP?" withAnswer:@"Perhaps..." withCategory:[NSNumber numberWithInteger:2]];
    [_quizContainer addObject: q6];
}

- (QuizObject *)grabRandomQuestionGivenCategory: (NSNumber *)category withPriorQuestion:(QuizObject *)lastQuestion{
    NSMutableArray *arrayOfCategoryQuestions = [[NSMutableArray alloc]init];
    
    for (NSUInteger i = 0; i < _quizContainer.count; i++){
        QuizObject *obj = [_quizContainer objectAtIndex:i];
        NSInteger cat = [[obj category] integerValue];
        if (cat != [category integerValue] || obj == lastQuestion)
            continue;
        
        [arrayOfCategoryQuestions addObject:obj];
    }
    
    uint32_t rand = arc4random();
    rand = rand % [arrayOfCategoryQuestions count];
    
    return [arrayOfCategoryQuestions objectAtIndex:rand];
}

@end
