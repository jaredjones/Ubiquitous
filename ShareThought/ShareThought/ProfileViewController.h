//
//  ProfileViewController.h
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/12/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProfileViewController : UIViewController
@property (nonatomic, strong) NSString *loggedInEmail;
@property (nonatomic, strong) NSString *fullname;
@property (nonatomic, strong) NSString *profileDescription;
@end
