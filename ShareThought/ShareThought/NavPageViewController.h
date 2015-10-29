//
//  NavPageViewController.h
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/29/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavPageViewController : UIPageViewController
@property NSUInteger pageIndex;
@property NSString *pageTitle;
@property UIViewController *ProfileView;
@property UITableView *FriendsListView;
@property UIViewController *SettingsView;

@end
