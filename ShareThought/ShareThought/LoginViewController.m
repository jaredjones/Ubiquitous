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
#import "NSString+StringVerification.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginEmail;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
 


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
