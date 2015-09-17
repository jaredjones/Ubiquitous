//
//  ViewController.m
//  Exercise3Group7
//
//  Created by Jared Jones on 9/17/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "NSString+StringVerification.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *passwordButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    BOOL emailExist = [User doesEmailExist: [_emailTextField text]];
    UIAlertView *msg;
    BOOL hasErrorOccured = NO;
    NSString *errorTitle;
    NSString *errorMsg;
    
    
    
    if (!emailExist){
        User *u = [[User alloc]initWithUser:[_emailTextField text] withPassword:[_passwordTextField text]];
        [User storeDataInNSUserDefaults:u];
    }
    
    
    if (hasErrorOccured){
        msg = [[UIAlertView alloc]initWithTitle:errorTitle
                                        message:errorMsg
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [msg show];
        return;
    }
}
@end
