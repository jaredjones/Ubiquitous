//
//  ProfileTopView.m
//  ShareThought
//
//  Created by Timothy Dickson on 11/15/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ProfileViewController.h"
#import "ProfileTopView.h"
#import "UILabel+Width.h"

@interface ProfileTopView ()

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation ProfileTopView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        _profileImageView = [[UIImageView alloc] init];
        _usernameLabel = [[UILabel alloc] init];
        _nameLabel = [[UILabel alloc] init];
        [_profileImageView setBackgroundColor:[UIColor darkGrayColor]];
        _usernameLabel.font = [UIFont fontWithName:@"Gill Sans" size:22.0f];
        _usernameLabel.textColor = [UIColor lightGrayColor];
        _usernameLabel.textAlignment = NSTextAlignmentCenter;
        
        _nameLabel.font = [UIFont fontWithName:@"Gill Sans" size:26.0f];
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_profileImageView];
        [self addSubview:_usernameLabel];
        [self addSubview:_nameLabel];
        
        
        return self;
    }
    return nil;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_profileImageView setFrame:CGRectMake(self.frame.size.width / 2 -  (self.frame.size.width / 3) / 2,
                                           self.frame.size.height / 2 - (self.frame.size.width / 3) / 2,
                                           self.frame.size.width / 3,
                                           self.frame.size.width / 3)];
    _profileImageView.clipsToBounds = YES;
    [self setRoundedView:_profileImageView toDiameter:self.frame.size.width / 3];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    // Give the layer the same bounds as your image view
    [circleLayer setBounds:CGRectMake(0.0f, 0.0f, [_profileImageView bounds].size.width,
                                      [_profileImageView bounds].size.height)];
    // Position the circle anywhere you like, but this will center it
    // In the parent layer, which will be your image view's root layer
    [circleLayer setPosition:CGPointMake([_profileImageView frame].size.width/2.0f,
                                         [_profileImageView frame].size.height/2.0f)];
    // Create a circle path.
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:
                          CGRectMake(0, 0, _profileImageView.frame.size.width, _profileImageView.frame.size.height)];
    
    // Set the path on the layer
    [circleLayer setPath:[path CGPath]];
    // Set the stroke color
    [circleLayer setStrokeColor:[[UIColor colorWithRed:223.0/255.0f green:127.0/255.0f blue:92.0/255.0f alpha:1.0f] CGColor]];
    [circleLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // Set the stroke line width
    [circleLayer setLineWidth:7.0f];
    
    // Add the sublayer to the image view's layer tree
    [[_profileImageView layer] addSublayer:circleLayer];
}

- (void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}
- (UIImageView*)getProfileImageView{
    return _profileImageView;
}

- (void)changeProfilePhoto: (UIImage *)photo{
    [_profileImageView.layer setMinificationFilter:kCAFilterTrilinear];
    _profileImageView.image = photo;
}

- (void)setUsername: (NSString *) username{
    [_usernameLabel setText:username];
    [_usernameLabel setFrame:CGRectMake(self.frame.size.width / 2 - [_usernameLabel getWidth] / 2, 30.0f, [_usernameLabel getWidth], 26.0f)];
}

- (void)setName: (NSString *) name{
    [_nameLabel setText:name];
    [self layoutSubviews];
    
    [_nameLabel setFrame:CGRectMake(self.frame.size.width / 2 - [_nameLabel getWidth] / 2,
                                    _profileImageView.frame.origin.y + _profileImageView.frame.size.height + 10.0,
                                    [_nameLabel getWidth],
                                    32.0f)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
