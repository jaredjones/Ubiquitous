//
//  RegistrationViewController.m
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/10/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "RegistrationViewController.h"
#import "User.h"
#import "NetworkManager.h"
#import "NSString+StringVerification.h"

#define HORIZONTAL_START_POINT  CGPointMake(0, 0.5)
#define HORIZONTAL_END_POINT    CGPointMake(1, 0.5)

@interface RegistrationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *registrationEmail;
@property (weak, nonatomic) IBOutlet UITextField *registrationPassword;
@property (weak, nonatomic) IBOutlet UIButton *verifyRegistration;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UIButton *registrationButton;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myButtonChange:_registrationButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.registrationEmail resignFirstResponder];
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.descriptionField resignFirstResponder];
    [self.registrationPassword resignFirstResponder];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)registrationButtonPressed:(id)sender {
    [[NetworkManager sharedManager] registerWithEmail:_registrationEmail.text withPassword:_registrationPassword.text withFirstName:_firstNameField.text withLastName:_lastNameField.text withAboutYou:_descriptionField.text withUserName:_userName.text];
    
    /*BOOL emailExist = [User doesEmailExist: [_registrationEmail text]];
    UIAlertController *msg;
    
    if (![[_registrationEmail text] isValidEmail]) {
        msg= [UIAlertController alertControllerWithTitle:@"Invalid Email"
                                                 message:@"The email address you entered is not in a valid format!"
                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {NSLog(@"OK button was pressed");
        }];
        
        [msg addAction:defaultAction];
        return;
    }
    
    if (emailExist) {
        msg= [UIAlertController alertControllerWithTitle:@"Email Already in Use"
                                                 message:@"The email address you entered is already registered!"
                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {NSLog(@"OK button was pressed");
        }];
        
        [msg addAction:defaultAction];
        return;
    }
    
    
    User *u = [[User alloc]initWithUser:[_registrationEmail text] withPassword:[_registrationPassword text] withFirstName:[_firstNameField text] withLastName:[_lastNameField text] withProfileDesc:[_descriptionField text]];
    [User storeDataInNSUserDefaults:u];
    
    [self performSegueWithIdentifier:@"registrationToLoginSegue" sender:self];
    return;
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
