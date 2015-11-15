//
//  BottomProfileView.m
//  ShareThought
//
//  Created by Timothy Dickson on 11/15/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "BottomProfileView.h"

@implementation BottomProfileView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:51.0/255.0 green:46.0/255.0 blue:61.0/255.0 alpha:1.0f].CGColor);
    
    CGContextSetLineWidth(context, 4.0f);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.frame.size.width, 0);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 3.0f);
    CGContextMoveToPoint(context, 0, self.frame.size.height);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    
    CGContextStrokePath(context);
}


@end
