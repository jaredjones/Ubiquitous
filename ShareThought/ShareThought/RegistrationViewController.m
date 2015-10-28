//
//  RegistrationViewController.m
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/10/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "RegistrationViewController.h"
#import "User.h"
#import "NSString+StringVerification.h"

@interface RegistrationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *registrationEmail;
@property (weak, nonatomic) IBOutlet UITextField *registrationPassword;
@property (weak, nonatomic) IBOutlet UIButton *verifyRegistration;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_registrationEmail resignFirstResponder];
    [_registrationPassword resignFirstResponder];
}
- (IBAction)registrationButtonPressed:(id)sender {
    BOOL emailExist = [User doesEmailExist: [_registrationEmail text]];
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
