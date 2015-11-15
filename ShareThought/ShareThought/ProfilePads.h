//
//  ProfilePads.h
//  ShareThought
//
//  Created by Tim Dickson on 11/2/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilePads : UIButton
- (void)setButtonLabelString:(NSString *)buttonString;
- (void)setBorderLinePositionIsLeft: (BOOL)isLeft;
- (void)setBackgroundImage:(UIImage *)image withPressed:(UIImage *)pressedImage withHeight: (CGFloat *) otherHeight;
@end
