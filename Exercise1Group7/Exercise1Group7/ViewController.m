//
//  ViewController.m
//  Exercise1Group7
//
//  Created by ubicomp7 on 9/3/15.
//  Copyright (c) 2015 ubicomp7. All rights reserved.
//

#import "ViewController.h"
#import "QuizManager.h"
#import "QuizObject.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIButton *showQuestionButton;
@property (weak, nonatomic) IBOutlet UIButton *showAnswerButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *categorySegmentedControl;

@property (strong, nonatomic) QuizManager *quizManager;

@end

QuizObject *currentQuestion;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _quizManager = [[QuizManager alloc]init];
    [_quizManager createQuizObjects];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showQuestionPressed:(id)sender {
    QuizObject *obj = [_quizManager grabRandomQuestionGivenCategory:[NSNumber numberWithInteger:[_categorySegmentedControl selectedSegmentIndex]] withPriorQuestion:currentQuestion];
    currentQuestion = obj;
    
    [_questionLabel setText:[obj question]];
    [_answerLabel setText:[obj answer]];
    
    [_answerLabel setHidden:YES];
    [_showAnswerButton setEnabled:YES];
}

- (IBAction)showAnswerPressed:(id)sender {
    [_answerLabel setHidden:NO];
    [_showAnswerButton setEnabled:NO];
}

@end
