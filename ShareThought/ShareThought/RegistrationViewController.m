//
//  RegistrationViewController.m
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/10/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "RegistrationViewController.h"
# import "User.h"

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
    User *u = [[User alloc]initWithUser:[_registrationEmail text] withPassword:[_registrationPassword text] withFirstName:[_firstNameField text] withLastName:[_lastNameField text] withProfileDesc:[_descriptionField text]];
    [User storeDataInNSUserDefaults:u];
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
