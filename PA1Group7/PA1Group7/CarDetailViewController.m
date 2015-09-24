//
//  CarDetailViewController.m
//  PA1Group7
//
//  Created by Jared Jones on 9/24/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "CarDetailViewController.h"

@interface CarDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *makeLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *vinLabel;

@end

@implementation CarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    _makeLabel.text = [_car make];
    _modelLabel.text = [_car model];
    _yearLabel.text = [[_car year] stringValue];
    _vinLabel.text = [_car vin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
