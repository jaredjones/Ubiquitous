//
//  ViewController.m
//  PA1Group7
//
//  Created by Jared Jones on 9/24/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Validation.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *makeTextField;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *vinTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addVehicleButtonTapped:(id)sender {
    UIAlertView *alert;
    NSString *msg = @"";
    if ([[_makeTextField text] length] == 0){
        msg = [msg stringByAppendingString:@"You must supply a Car's make!"];
    }
    if ([[_modelTextField text] length] == 0){
        msg = [msg stringByAppendingString:@"\nYou must supply a Car's model!"];
    }
    if ([[_yearTextField text] length] == 0){
        msg = [msg stringByAppendingString:@"\nYou must supply a Car's year!"];
    }
    if ([[_vinTextField text] length] == 0){
        msg = [msg stringByAppendingString:@"\nYou must supply a Car's VIN!"];
    }
    
    if ([msg length] != 0){
        alert = [[UIAlertView alloc]initWithTitle:@"Empty Field(s)"
                                          message:msg
                                         delegate:nil
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (![[_yearTextField text] isValidYear]){
        alert = [[UIAlertView alloc]initWithTitle:@"Invalid Year"
                                          message:@"The year you entered is not a valid year!"
                                         delegate:nil
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (![[_vinTextField text] isValidVINNumber]){
        alert = [[UIAlertView alloc]initWithTitle:@"Invalid VIN"
                                          message:@"The VIN you entered is not a proper VIN Format! VINs are 17 characters long and don't contain: I, O, and Q."
                                         delegate:nil
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
}

- (IBAction)showVehicleListButtonTapped:(id)sender {
}

@end
