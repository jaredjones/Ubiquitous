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

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:51.0/255.0 green:46.0/255.0 blue:61.0/255.0 alpha:1.0f].CGColor);
    
    CGContextSetLineWidth(context, 1.0f);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.bounds.size.width, 0);
    
    //Variability Line
    if (_isLeft){
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 0, self.bounds.size.height);
    }else{
        CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    }
    
    CGContextMoveToPoint(context, 0, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    
    CGContextStrokePath(context);
    
}

@end
