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

@property (weak, nonatomic) IBOutlet UIView *profileTopView;
@property (weak, nonatomic) IBOutlet ProfilePads *friendsButton;
@property (weak, nonatomic) IBOutlet ProfilePads *deleteFriendButton;
@property (weak, nonatomic) IBOutlet ProfilePads *numberOfFriendsButton;
@property (weak, nonatomic) IBOutlet ProfilePads *addFriendButton;
@property (weak, nonatomic) IBOutlet ProfilePads *startChatButton;

@end


@implementation ProfileViewController

- (void)viewDidLoad{
    
}

- (void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidLayoutSubviews{
    [_friendsButton setBorderLinePositionIsLeft:NO];
    [_deleteFriendButton setBorderLinePositionIsLeft:YES];
    [_numberOfFriendsButton setBorderLinePositionIsLeft:NO];
    [_addFriendButton setBorderLinePositionIsLeft:YES];
    [_addFriendButton setBackgroundImage:[UIImage imageNamed:@"addfriend.png"] withPoint:nil];
    [_startChatButton setBackgroundImage:[UIImage imageNamed:@"deletefriend.png"] withPoint:nil];
}

- (void)viewDidAppear:(BOOL)animated{

}

@end