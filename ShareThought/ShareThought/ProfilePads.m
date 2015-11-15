//
//  ProfilePads.m
//  ShareThought
//
//  Created by Tim Dickson on 11/2/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ProfilePads.h"
#import "UILabel+Width.h"

@interface ProfilePads ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UILabel *buttonLabel;
@property BOOL isLeft;

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *pressedImage;
@property CGFloat *oHeight;
@end

@implementation ProfilePads

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        _isLeft = YES;
        [self setBackgroundColor:[UIColor colorWithRed:38.0/255.0 green:36.0/255.0 blue:48.0/255.0 alpha:1.0f]];
        
        [self addTarget:self action:@selector(methodTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(methodTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [self addTarget:self action:@selector(methodTouchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(methodTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect labelFrame = CGRectMake(0, 0, self.frame.size.width, 20);
        
        _buttonLabel = [[UILabel alloc] initWithFrame:labelFrame];
        _buttonLabel.font = [UIFont fontWithName:@"Gill Sans" size:22.0f];
        _buttonLabel.textColor = [UIColor lightGrayColor];
        _buttonLabel.textAlignment = NSTextAlignmentCenter;
        
        return self;
    }
    return nil;
}

- (void) methodTouchDown: (id)sender{
    _backgroundImageView.image = _pressedImage;
    [self setBackgroundColor:[UIColor colorWithRed:72.0/255.0 green:80.0/255.0 blue:108.0/255.0 alpha:1.0f]];
}

- (void) methodTouchDragExit: (id)sender{
    _backgroundImageView.image = _normalImage;
    [self setBackgroundColor:[UIColor colorWithRed:38.0/255.0 green:36.0/255.0 blue:48.0/255.0 alpha:1.0f]];
}

- (void) methodTouchDragEnter: (id)sender{
    _backgroundImageView.image = _pressedImage;
    [self setBackgroundColor:[UIColor colorWithRed:72.0/255.0 green:80.0/255.0 blue:108.0/255.0 alpha:1.0f]];
}

- (void) methodTouchUpInside: (id)sender{
    _backgroundImageView.image = _normalImage;
    [self setBackgroundColor:[UIColor colorWithRed:38.0/255.0 green:36.0/255.0 blue:48.0/255.0 alpha:1.0f]];
}

- (void)setButtonLabelString:(NSString *)buttonString{
    [_buttonLabel setText:buttonString];
    [_buttonLabel removeFromSuperview];
    
    CGFloat widthIs = [_buttonLabel getWidth];
    
    CGRect frame = _buttonLabel.frame;
    frame.size = CGSizeMake(widthIs, _buttonLabel.frame.size.height);
    frame.origin = CGPointMake(self.frame.size.width / 2 - widthIs / 2, _backgroundImageView.frame.origin.y + _backgroundImageView.frame.size.height+5);
    [_buttonLabel setFrame:frame];
    [self addSubview:_buttonLabel];
}

- (void)setBorderLinePositionIsLeft: (BOOL)isLeft{
    _isLeft = isLeft;
    [self setNeedsDisplay];
}

- (void)setBackgroundImage:(UIImage *)image withPressed:(UIImage *)pressedImage withHeight: (CGFloat *) otherHeight{
    _normalImage = image;
    _pressedImage = pressedImage;
    _oHeight = otherHeight;
    _backgroundImageView = [[UIImageView alloc] initWithImage:image];
    [_backgroundImageView.layer setMinificationFilter:kCAFilterTrilinear];

    CGFloat imageShrinkSize = 0.5;
    
    CGFloat width;
    CGFloat height;
    if (otherHeight == nil){
        width = self.frame.size.width;
        height = self.frame.size.height;
    }else{
        width = self.frame.size.width;
        height = (*otherHeight);
    }
    
    [_backgroundImageView setContentMode:UIViewContentModeScaleToFill];
    _backgroundImageView.frame = CGRectMake(width / 2 - (height * imageShrinkSize) / 2,
                                            self.frame.size.height / 2 - (height * imageShrinkSize / 2) -(height * imageShrinkSize) * 0.2,
                                            height * imageShrinkSize,
                                            height * imageShrinkSize);
    [_backgroundImageView removeFromSuperview];
    [self addSubview:_backgroundImageView];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:51.0/255.0 green:46.0/255.0 blue:61.0/255.0 alpha:1.0f].CGColor);
    
    CGContextSetLineWidth(context, 1.0f);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.frame.size.width, 0);
    
    //Variability Line
    if (_isLeft){
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 0, self.frame.size.height);
    }else{
        CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    }
    
    CGContextMoveToPoint(context, 0, self.frame.size.height);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    
    CGContextStrokePath(context);
    
}

@end
