//
//  ContactListTableViewCell.m
//  Sharethought
//
//  Created by Aidaly Santamaria on 11/23/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "ContactListTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ContactListTableViewCell ()
@property (nonatomic, weak) IBOutlet UIButton *deleteButton;
@property (nonatomic, weak) IBOutlet UIButton *editButton;

@property (nonatomic, weak) IBOutlet UIView *contactDisplayView;
@property (nonatomic, weak) IBOutlet UIImageView *contactImageView;
@property (nonatomic, weak) IBOutlet UILabel *contactNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *contactDescLabel;

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRight;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeft;
@end

@implementation ContactListTableViewCell

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
    _deleteButton = deleteButton;
}

-(void)setEditButton:(UIButton *)editButton {
    editButton.backgroundColor = [UIColor colorWithRed:125.0/255.0f green:250.0/255.0f blue:164.0/255.0f alpha:1.0f];
    _editButton = editButton;
}

-(void)setContactDisplayView:(UIView *)contactDisplayView {
    contactDisplayView.backgroundColor = [UIColor darkGrayColor];
    _contactDisplayView = contactDisplayView;
}

-(void)setContactImageView:(UIImageView *)contactImageView {
    UIImage *image = [UIImage imageNamed:@"rose.jpg"];
    contactImageView.image = image;
    
    contactImageView.layer.cornerRadius = contactImageView.frame.size.width / 2;
    contactImageView.layer.masksToBounds = YES;
    
    _contactImageView = contactImageView;
}

-(void)setContactName:(NSString *)contactName {
    _contactName = contactName;
    _contactNameLabel.text = _contactName;
    _contactNameLabel.textColor = [UIColor whiteColor];
}

-(void)setContactDesc:(NSString *)contactDesc {
    _contactDesc = contactDesc;
    _contactDescLabel.text = _contactDesc;
    _contactDescLabel.textColor = [UIColor lightTextColor];
}

-(IBAction)buttonClicked:(id)sender {
    if (sender == _deleteButton) {
        [_delegate deleteButtonActionForContact:_contactName];
    }
    else if (sender == _editButton) {
        [_delegate editButtonActionForContact:_contactName];
    }
}

-(void)swipeRightWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    [UIView animateWithDuration:0.5 animations:^{
        _contactDisplayView.frame = CGRectOffset(_contactDisplayView.frame, _editButton.frame.size.width, 0.0);
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
