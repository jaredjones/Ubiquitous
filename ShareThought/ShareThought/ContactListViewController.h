//
//  ContactListViewController.h
//  ShareThought
//
//  Created by Aidaly Santamaria on 11/3/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
//- (UIColor*)colorPickerForNameLabel:(NSNumber *)theColorChoiceChoosen;
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;
-(void)deleteButtonActionForContact:(NSString *)contactName;
- (void)removeContact:(NSString *)contact;
@end
