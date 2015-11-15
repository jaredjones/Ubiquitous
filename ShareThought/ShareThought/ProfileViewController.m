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
    [_deleteFriendButton setBorderLinePositionIsLeft:YES];
    
    [_friendsButton setBackgroundImage:[UIImage imageNamed:@"friend.png"]];
    [_deleteFriendButton setBackgroundImage:[UIImage imageNamed:@"deletefriend.png"]];
}

- (void)viewWillAppear:(BOOL)animated{
    
}

@end