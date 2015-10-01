//
//  UserTableViewController.m
//  Exercise4Group7
//
//  Created by Jared Jones on 10/1/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "UserTableViewController.h"
#import "UserTableViewCell.h"
#import "User.h"

@implementation UserTableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *userArray = [User retrieveDataFromNSUserDefaults];
    return [userArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    if (cell == nil){
        cell = [[UserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
    }
    
    //NSArray *userArray = [User retrieveDataFromNSUserDefaults];
    cell.textLabel.hidden = YES;
    return cell;
}
@end
