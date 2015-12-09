//
//  ContactListTableViewCell.m
//  Sharethought
//
//  Created by Aidaly Santamaria on 11/23/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "ContactListTableViewCell.h"
#import "ProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NetworkManager.h"

@interface ContactListTableViewCell ()
@property (nonatomic, weak) IBOutlet UIButton *deleteButton;
@property (nonatomic, weak) IBOutlet UIButton *chatButton;

@property (nonatomic, weak) IBOutlet UIView *contactDisplayView;
@property (nonatomic, weak) IBOutlet UIImageView *contactImageView;
@property (nonatomic, weak) IBOutlet UILabel *contactNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *contactDescLabel; // We add buttons here

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRight;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic, strong) NSNumber *colorPicker;
@end

@implementation ContactListTableViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _colorPicker = @0;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightWithGestureRecognizer:)];
    _swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    _swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftWithGestureRecognizer:)];
    _swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [_contactDisplayView addGestureRecognizer:_swipeRight];
    [_contactDisplayView addGestureRecognizer:_swipeLeft];
}

-(void)setDeleteButton:(UIButton *)deleteButton {
    deleteButton.backgroundColor = [UIColor redColor];
    deleteButton.layer.cornerRadius = 10.0f;
    deleteButton.layer.masksToBounds = YES;
    _deleteButton = deleteButton;
}

-(void)setChatButton:(UIButton *)chatButton {
    [chatButton setBackgroundImage:[UIImage imageNamed:@"chaticon.png"] forState:UIControlStateNormal];
    _chatButton = chatButton;
}

-(void)setContactDisplayView:(UIView *)contactDisplayView {
    contactDisplayView.backgroundColor = [UIColor colorWithRed:54.0/255.0f green:58.0/255.0f blue:64.0/255.0f alpha:1.0f];
    _contactDisplayView = contactDisplayView;
}

- (void)updateUserIcon: (UIImage *)icon{
    _contactImageView.image = icon;
    _contactImageView.layer.cornerRadius = _contactImageView.frame.size.width / 2;
    _contactImageView.layer.masksToBounds = YES;
}

-(void)setContactImageView:(UIImageView *)contactImageView {
    UIImage *image = nil;
    contactImageView.image = image;
    
    contactImageView.layer.cornerRadius = contactImageView.frame.size.width / 2;
    contactImageView.layer.masksToBounds = YES;
    
    _contactImageView = contactImageView;
}

-(void)setContactName:(NSString *)contactName {
    _contactName = contactName;
    _contactNameLabel.text = _contactName;
    //_contactNameLabel.textAlignment =  NSTextAlignmentCenter;
    //_contactNameLabel.layer.cornerRadius = 15.0f;
    //_contactNameLabel.layer.masksToBounds = YES;
    _contactNameLabel.textColor = [UIColor whiteColor];
    //_contactNameLabel.backgroundColor = _theLabelColor;
}

/*-(void)setTheLabelColor:(UIColor *)theLabelColor{
    _theLabelColor = theLabelColor;
    _contactNameLabel.backgroundColor = _theLabelColor;
}*/

-(void)setContactDesc:(NSString *)contactDesc {
    _contactDesc = contactDesc;
    _contactDescLabel.text = _contactDesc;
    _contactDescLabel.textColor = [UIColor lightTextColor];
    //_contactDescLabel.textAlignment =  NSTextAlignmentCenter;
    //_contactDescLabel.layer.cornerRadius = 15.0f;
    //_contactDescLabel.layer.masksToBounds = YES;
}

-(IBAction)buttonClicked:(id)sender {
    if (sender == _deleteButton) {
        [[NetworkManager sharedManager] deleteContact:[_user username]];
        [_delegate deleteButtonActionForContact:_contactName];
    }
    else if (sender == _chatButton) {
        [_delegate chatButtonAction:sender withContactName:_contactName];
    }
}

-(void)swipeRightWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    [UIView animateWithDuration:0.5 animations:^{
        _contactDisplayView.frame = CGRectOffset(_contactDisplayView.frame, _chatButton.frame.size.width, 0.0);
    }];
}

-(void)swipeLeftWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    [UIView animateWithDuration:0.5 animations:^{
        _contactDisplayView.frame = CGRectOffset(_contactDisplayView.frame, -(_deleteButton.frame.size.width), 0.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
