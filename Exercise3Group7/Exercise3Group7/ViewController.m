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
#import "LoggedInViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *passwordButton;

@property (weak, nonatomic) IBOutlet UILabel *strengthLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_passwordTextField setSecureTextEntry:YES];
    [self setTitle:@"Logout"];
    
    _passwordTextField.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES];
    [_passwordTextField setText:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_emailTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *pass = [_passwordTextField text];
    BOOL containsNumber = [pass containsNumber];
    BOOL containsPunc = [pass hasPunctuation];
    BOOL containsUpp = [pass containsUpperCaseCharacter];
    
    NSUInteger size = 0;
    if (containsNumber)
        size++;
    if (containsPunc)
        size++;
    if (containsUpp)
        size++;
    
    switch (size){
        case 0:
            [_strengthLabel setText:@"Strength: Weak"];
            break;
        case 1:
            [_strengthLabel setText:@"Strength: Okay"];
            break;
        case 2:
            [_strengthLabel setText:@"Strength: Great"];
            break;
        case 3:
            [_strengthLabel setText:@"Strength: Strong"];
            break;
        default:
            [_strengthLabel setText:@"Strength: Weak"];
            break;
    }
    
    return YES;
}

- (IBAction)loginButtonPressed:(id)sender {
    BOOL emailExist = [User doesEmailExist: [_emailTextField text]];
    UIAlertView *msg;
    
    if (![[_emailTextField text] isValidEmail]){
        msg = [[UIAlertView alloc]initWithTitle:@"Invalid Email"
                                        message:@"The email you entered is not of a valid format!"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [msg show];
        return;
    }
    
    if (!emailExist){
        User *u = [[User alloc]initWithUser:[_emailTextField text] withPassword:[_passwordTextField text]];
        [User storeDataInNSUserDefaults:u];
        
        [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
        return;
    }
    
    //If email already existed check for valid user/pass
    if (![User emailCredentialsValid:[_emailTextField text] withPassword:[_passwordTextField text]]){
        msg = [[UIAlertView alloc]initWithTitle:@"Invalid Credentials"
                                        message:@"The email/password combination you entered is invalid!"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [msg show];
        return;
    }
    [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LoggedInViewController *loggedInVC = [segue destinationViewController];
    loggedInVC.loggedInEmail = [_emailTextField text];
}
@end
