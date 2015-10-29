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
    [self myButtonChange:_loginButton];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
