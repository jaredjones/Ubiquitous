//
//  ProfileViewController.h
//  ShareThought
//
//  Created by Tim Dickson on 11/2/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"

@interface ProfileViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (void)changeUser: (User *)u;
+ (NSData *)dataFromHexString:(NSString *)string;
@end
