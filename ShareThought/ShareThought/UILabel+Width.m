//
//  UILabel+Width.m
//  ShareThought
//
//  Created by Timothy Dickson on 11/15/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "UILabel+Width.h"

@implementation UILabel (Width)

- (CGFloat)getWidth{
    CGFloat widthIs = [self.text boundingRectWithSize:self.frame.size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{ NSFontAttributeName:self.font }
                                                    context:nil].size.width;
    return widthIs;
}

@end
