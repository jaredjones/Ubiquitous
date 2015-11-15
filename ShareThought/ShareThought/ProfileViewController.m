//
//  ProfileViewController.m
//  ShareThought
//
//  Created by Tim Dickson on 11/2/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfilePads.h"
#import "ProfileTopView.h"

@interface ProfileViewController()

@property (weak, nonatomic) IBOutlet ProfileTopView *profileTopView;
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
    [_addFriendButton setBackgroundImage:[UIImage imageNamed:@"addfriend.png"] withPressed:[UIImage imageNamed:@"addfriend-pressed.png"] withHeight:nil];
    [_startChatButton setBackgroundImage:[UIImage imageNamed:@"chaticon.png"] withPressed:[UIImage imageNamed:@"chaticon-pressed.png"] withHeight:nil];
    
    CGFloat height = _addFriendButton.frame.size.height;
    [_deleteFriendButton setBackgroundImage:[UIImage imageNamed:@"deletefriend.png"] withPressed:[UIImage imageNamed:@"deletefriend-pressed.png"] withHeight:&height];
    [_friendsButton setBackgroundImage:[UIImage imageNamed:@"friend.png"] withPressed:[UIImage imageNamed:@"friend-pressed.png"] withHeight:&height];
    
    [_addFriendButton setButtonLabelString:@"Add"];
    [_deleteFriendButton setButtonLabelString:@"Delete"];
    [_startChatButton setButtonLabelString:@"Chat"];
    [_friendsButton setButtonLabelString:@"Friends"];
    
<<<<<<< HEAD
    [_profileTopView changeProfilePhoto:[UIImage imageNamed:@"morgie.png"]];
=======
    [_profileTopView changeProfilePhoto:[UIImage imageNamed:@"morgie.jpg"]];
    [_profileTopView setUsername:@"toastieghostie"];
    [_profileTopView setName:@"Morgan Nicole Vegsund"];
>>>>>>> e40aca7f0c638e48c158ee450845a63dbf6a20d3
}

- (void)viewDidAppear:(BOOL)animated{

}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)personsFriendsPressed:(id)sender {
    NSLog(@"Person's Friends Pressed");
}
- (IBAction)deleteFriendPressed:(id)sender {
    NSLog(@"Delete Friend Pressed");
}
- (IBAction)clickToChatPressed:(id)sender {
    NSLog(@"Click to Chat Pressed");
}
- (IBAction)addFriendPressed:(id)sender {
    NSLog(@"Add Friend Pressed");
}
@end