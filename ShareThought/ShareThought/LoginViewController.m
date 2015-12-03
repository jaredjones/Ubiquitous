//
//  LoginViewController.m
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/26/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "NetworkManager.h"

#import "LoginViewController.h"
#import "User.h"
#import "ProfileViewController.h"
#import "NSString+StringVerification.h"

#define HORIZONTAL_START_POINT  CGPointMake(0, 0.5)
#define HORIZONTAL_END_POINT    CGPointMake(1, 0.5)

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginEmail;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.loginEmail.delegate = self;
    self.loginPassword.delegate = self;
    
    [self myButtonChange:_loginButton];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedLoggedInNotification:)
                                                 name:@"LoggedInNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedLoggedInNotification:)
                                                 name:@"LoginFailureInNotification"
                                               object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    
    [[NetworkManager sharedManager] loginWithEmail:_loginEmail.text withPassword:_loginPassword.text];
    
    /*
    UIAlertController *msg;
 
    //If email exists check for valid user/pass combination
    if (![User emailCredentialsValid:[_loginEmail text] withPassword:[_loginPassword text]]){
        msg= [UIAlertController alertControllerWithTitle:@"Invalid Credentials"
                                                  message:@"The email/password combination you entered is invalid!"
                                           preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {NSLog(@"OK button was pressed");
        }];
              
        [msg addAction:defaultAction];
              
        return;
    }
     [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
     */
}


-(void) myButtonChange: (UIButton*) btn
{
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    CAGradientLayer *btnGradient = [CAGradientLayer layer];
    btnGradient.frame = btn.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)[[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor],
                          (id)[[UIColor colorWithRed:0.0/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f] CGColor],
                          
                          
                          nil];
    [btn.layer insertSublayer:btnGradient atIndex:0];
    
    btnGradient.startPoint = HORIZONTAL_START_POINT;
    
    btnGradient.endPoint = HORIZONTAL_END_POINT;
    CALayer *btnLayer = [btn layer];
    [btnLayer setMasksToBounds:YES];
    
    [[btn layer] setBorderWidth:0.0f];
    [[btn layer] setCornerRadius:10.0f];    
}

- (void) receivedLoggedInNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"LoggedInNotification"]){
        User *u = [[notification userInfo] objectForKey:@"User"];
        
        [[User me] setSSO:[[notification userInfo] objectForKey:@"SSO"]];
        [[User me] setUsername:[u username]];
        [[User me] setFname:[u fname]];
        [[User me] setLname:[u lname]];
        [[User me] setEmail:[u email]];
        [[User me] setProfileDescription:[u profileDescription]];
        
        [self performSegueWithIdentifier:@"loggedInToProfile" sender:self];
    }
    if ([[notification name] isEqualToString:@"LoginFailureInNotification"]){
        UIAlertController *msg = [UIAlertController alertControllerWithTitle:@"Login Failed"
                                                                     message:@"The username/password combination you have chosen is invalid!"
                                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
        [msg addAction:defaultAction];
        [self presentViewController:msg animated:YES completion:nil];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_loginEmail resignFirstResponder];
    [_loginPassword resignFirstResponder];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([segue.identifier isEqualToString:@"loggedInToProfile"]){
        ProfileViewController *vc = [segue destinationViewController];
        [vc changeUser:[User me]];
    }
}


@end
