//
//  ProfileViewController.m
//  ShareThought
//
//  Created by Tim Dickson on 11/2/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfilePads.h"

@interface ProfileViewController()
@property (weak, nonatomic) IBOutlet ProfilePads *friendsButton;
@property (weak, nonatomic) IBOutlet ProfilePads *deleteFriendButton;
@property (strong, nonatomic) UIImageView *shareThoughtProfileView;
@end


@implementation ProfileViewController

- (void)viewDidLoad{
    [_friendsButton setBorderLinePositionIsLeft:NO];
    [_friendsButton setBorderLinePositionIsLeft:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
}

@end