//
//  NoNetworkViewController.m
//  ShareThought
//
//  Created by Jared Jones on 12/3/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "NoNetworkViewController.h"

@interface NoNetworkViewController ()

@property (nonatomic, strong) UILabel* noConnLabel;

@end

@implementation NoNetworkViewController

- (void)viewDidLoad{
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    _noConnLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height / 2, self.view.frame.size.width, 30.0f)];
    [_noConnLabel setTextColor:[UIColor whiteColor]];
    [_noConnLabel setText:@"Reestablishing Connection..."];
    _noConnLabel.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:_noConnLabel];
}

@end
