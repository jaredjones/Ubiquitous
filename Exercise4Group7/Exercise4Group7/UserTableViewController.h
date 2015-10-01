//
//  UserTableViewController.h
//  Exercise4Group7
//
//  Created by Jared Jones on 10/1/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewController : UITableViewController <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *favoriteFruitSearchBar;

@end
