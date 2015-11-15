//
//  ProfilePads.m
//  ShareThought
//
//  Created by Tim Dickson on 11/2/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ProfilePads.h"

@interface ProfilePads ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property BOOL isLeft;
@end

@implementation ProfilePads

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        _isLeft = YES;
        [self setBackgroundColor:[UIColor colorWithRed:38.0/255.0 green:36.0/255.0 blue:48.0/255.0 alpha:1.0f]];
        return self;
    }
    return nil;
}

- (void)setBorderLinePositionIsLeft: (BOOL)isLeft{
    _isLeft = isLeft;
    [self setNeedsDisplay];
}

- (void)setBackgroundImage:(UIImage *)image withHeight: (CGFloat *) otherHeight{
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
                                            self.frame.size.height / 2 - (height * imageShrinkSize / 2),
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
