//
//  ViewController.m
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/8/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"

#import "DemoMessagesViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *backgroundVisualEffectView;

@property (strong, nonatomic) UIImageView *shareThoughtLogoView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *loginVisualEffectView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *registerVisualEffectView;
@property (weak, nonatomic) IBOutlet UILabel *copyrightNoticeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loginVisualEffectView.layer.cornerRadius = 10.0f;
    _loginVisualEffectView.clipsToBounds = YES;
    _registerVisualEffectView.layer.cornerRadius = 10.0f;
    _registerVisualEffectView.clipsToBounds = YES;
    
    UIImage *shareThoughtLogo = [UIImage imageNamed:@"SharethoughtLogo.png"];
    _shareThoughtLogoView = [[UIImageView alloc]initWithImage:shareThoughtLogo];
    _shareThoughtLogoView.frame = CGRectMake(self.view.bounds.size.width / 2 - 355/2, -291, 355.0, 291.0);
    [self.view addSubview:_shareThoughtLogoView];
    
    //[_backgroundVisualEffectView setEffect:[BackgroundBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    
    // Set vertical effect
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-50);
    verticalMotionEffect.maximumRelativeValue = @(50);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-50);
    horizontalMotionEffect.maximumRelativeValue = @(50);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    [_backgroundImageView addMotionEffect:group];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    _loginVisualEffectView.hidden = YES;
    _registerVisualEffectView.hidden = YES;
    _shareThoughtLogoView.hidden = YES;
    _copyrightNoticeLabel.alpha = 0;
}

- (void)viewDidAppear:(BOOL)animated{
    CGFloat sTLHeight = _shareThoughtLogoView.frame.size.height;
    CGFloat sTLWidth = _shareThoughtLogoView.frame.size.width;
    _shareThoughtLogoView.frame = CGRectMake(self.view.bounds.size.width / 2 - sTLWidth/2, self.view.bounds.size.width / 2 - sTLHeight/2, sTLWidth, sTLHeight);
    
    _loginVisualEffectView.frame = CGRectMake(self.view.bounds.size.width / 2 - _loginVisualEffectView.frame.size.width - 10, _shareThoughtLogoView.frame.origin.y + _shareThoughtLogoView.frame.size.height / 2 + 40, 94, 64);
    _registerVisualEffectView.frame = CGRectMake(self.view.bounds.size.width / 2 + 10, _shareThoughtLogoView.frame.origin.y + _shareThoughtLogoView.frame.size.height / 2 + 40, 101, 64);
    
    CABasicAnimation *moveButtonDown = [CABasicAnimation animationWithKeyPath:@"position"];
    moveButtonDown.additive = YES;
    moveButtonDown.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.0, -_shareThoughtLogoView.frame.size.height)];
    moveButtonDown.toValue = [NSValue valueWithCGPoint:CGPointZero];
    moveButtonDown.autoreverses = NO;
    moveButtonDown.duration = 0.75;
    moveButtonDown.repeatCount = 0;
    [_loginVisualEffectView.layer addAnimation:moveButtonDown forKey:@"myMoveButtonDownAnimation"];
    [_registerVisualEffectView.layer addAnimation:moveButtonDown forKey:@"myMoveButtonDownAnimation"];
    _loginVisualEffectView.hidden = NO;
    _registerVisualEffectView.hidden = NO;
    _shareThoughtLogoView.hidden = NO;
    
    CABasicAnimation *moveLogoDown = [CABasicAnimation animationWithKeyPath:@"position"];
    moveLogoDown.additive = YES;
    moveLogoDown.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.0, -_shareThoughtLogoView.frame.size.height)];
    moveLogoDown.toValue = [NSValue valueWithCGPoint:CGPointZero];
    moveLogoDown.autoreverses = NO;
    moveLogoDown.duration = 0.75;
    moveLogoDown.repeatCount = 0;
    [_shareThoughtLogoView.layer addAnimation:moveLogoDown forKey:@"myMoveDownAnimation"];
    
    [CATransaction commit];
    
    [UIView animateWithDuration:1.0 delay:0.25 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _copyrightNoticeLabel.alpha = 1;}
                     completion:nil];
}
- (IBAction)registerButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"registerSegue" sender:self];
}
- (IBAction)loginButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
}
- (IBAction)chatButtonTapped:(id)sender {
    DemoMessagesViewController *vc = [DemoMessagesViewController messagesViewController];
    vc.delegateModal = self;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
