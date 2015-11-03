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
@property NSString* imagePathForFriendsList;
@property UIImage* myImageForFriendsList;
@property NSString* imagePathForDeleteFriend;
@property UIImage* myImageForDeleteFriend;
@property NSNumber* thePadNumberLocation;
@end

@implementation ProfilePads

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        _isLeft = YES;
        _imagePathForFriendsList = [[NSBundle mainBundle] pathForResource:@"addIconFlat" ofType:@"png"];
        _myImageForFriendsList = [[UIImage alloc] initWithContentsOfFile:_imagePathForFriendsList];
        _imagePathForDeleteFriend = [[NSBundle mainBundle] pathForResource:@"fs-floppy" ofType:@"png"];
        _myImageForDeleteFriend = [[UIImage alloc] initWithContentsOfFile:_imagePathForDeleteFriend];
        [self setBackgroundColor:[UIColor colorWithRed:38.0/255.0 green:36.0/255.0 blue:48.0/255.0 alpha:1.0f]];
        return self;
    }
    return nil;
}

- (void)setBorderLinePositionIsLeft: (BOOL)isLeft forAGivenPadNumber:(NSNumber*) aPadNumber{
    _isLeft = isLeft;
    _thePadNumberLocation = aPadNumber;
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
    
    if(_thePadNumberLocation.integerValue == 0){
        [_myImageForDeleteFriend drawInRect:rect ];
    }
    if(_thePadNumberLocation.integerValue == 1){
        [_myImageForFriendsList drawInRect:rect ];
    }
    
    CGContextMoveToPoint(context, 0, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    
    CGContextStrokePath(context);
    
}

@end
