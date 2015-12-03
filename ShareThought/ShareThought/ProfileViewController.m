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
#import "NetworkManager.h"
#import "NSData+Conversion.h"

@interface ProfileViewController()

@property (weak, nonatomic) IBOutlet ProfileTopView *profileTopView;
@property (weak, nonatomic) IBOutlet ProfilePads *friendsButton;
@property (weak, nonatomic) IBOutlet ProfilePads *deleteFriendButton;
@property (weak, nonatomic) IBOutlet ProfilePads *numberOfFriendsButton; //aboutButton
@property (weak, nonatomic) IBOutlet ProfilePads *addFriendButton;
@property (weak, nonatomic) IBOutlet ProfilePads *startChatButton;
@property (weak, nonatomic) IBOutlet UIButton *navigationBackButton;

@property (strong, nonatomic)User *user;

@end


@implementation ProfileViewController

- (void)viewDidLoad{
    [_navigationBackButton.imageView.layer setMinificationFilter:kCAFilterTrilinear];
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
    [_numberOfFriendsButton setBackgroundImage:[UIImage imageNamed:@"about.png"] withPressed:[UIImage imageNamed:@"about-pressed.png"] withHeight:&height];
    
    [_addFriendButton setButtonLabelString:@"Add"];
    [_deleteFriendButton setButtonLabelString:@"Delete"];
    [_startChatButton setButtonLabelString:@"Chat"];
    [_friendsButton setButtonLabelString:@"Friends"];
    [_numberOfFriendsButton setButtonLabelString:@"About"];
   
    [_profileTopView changeProfilePhoto:[_user profilePic]];
    [_profileTopView setUsername:[_user username]];
    [_profileTopView setName:[[[_user fname] stringByAppendingString:@" "] stringByAppendingString:[_user lname]]];
    
    UIImageView *imgView = [_profileTopView getProfileImageView];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoTapped:)];
    [tapGest setNumberOfTapsRequired:1];
    [imgView addGestureRecognizer:tapGest];
}

- (void)viewDidAppear:(BOOL)animated{

}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (IBAction)navigationBackButtonPressed:(id)sender {
    //Temporarily Logout
    [[NetworkManager sharedManager] logout];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
- (IBAction)aboutUsOrEditButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"aboutUserSegue" sender:self];
}

- (void)photoTapped: (UITapGestureRecognizer *)tap{
    if ([User me] == _user){
        NSLog(@"Tapped");
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    _user.profilePic = chosenImage;
    [_profileTopView changeProfilePhoto:chosenImage];

    NSData *imgData = UIImageJPEGRepresentation(chosenImage, 0.5);
    NSString *hexImg = [imgData hexadecimalString];
    NSString *post = [NSString stringWithFormat:@"SSO=%@&Image=%@", [[User me]SSO], hexImg];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://gaea.uvora.com/sharethought/process.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request] resume];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

+ (NSData *)dataFromHexString:(NSString *)string
{
    string = [string lowercaseString];
    NSMutableData *data= [NSMutableData new];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i = 0;
    NSUInteger length = string.length;
    while (i < length-1) {
        char c = [string characterAtIndex:i++];
        if (c < '0' || (c > '9' && c < 'a') || c > 'f')
            continue;
        byte_chars[0] = c;
        byte_chars[1] = [string characterAtIndex:i++];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}

- (void)changeUser:(User *)u{
    NSLog(@"changeUser");
    _user = u;
    NSURL *URL = [NSURL URLWithString:[@"http://gaea.uvora.com/sharethought/process.php?o=1&user=" stringByAppendingString:[_user username]]];
    NSError *error;
    NSString *stringFromFileAtURL = [[NSString alloc]
                                     initWithContentsOfURL:URL
                                     encoding:NSUTF8StringEncoding
                                     error:&error];
    if (![stringFromFileAtURL isEqualToString:@""]){
        NSData *imgData = [ProfileViewController dataFromHexString:stringFromFileAtURL];
        UIImage *img = [UIImage imageWithData:imgData];
        _user.profilePic = img;
        [_profileTopView changeProfilePhoto:img];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}
@end
