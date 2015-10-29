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
#import "MapViewController.h"

@interface UserTableViewController ()

@end

@implementation UserTableViewController

BOOL isSearching = false;

- (void)viewDidLoad{
    _favoriteFruitSearchBar.delegate = self;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length != 0)
        isSearching = true;
    else
        isSearching = false;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *userArray = [User retrieveDataFromNSUserDefaults];
    
    if (!isSearching)
        return [userArray count];
    
    NSMutableArray *newUserArray = [[NSMutableArray alloc]init];
    for (User *u in userArray){
        if ([u.favoriteFruit hasPrefix:_favoriteFruitSearchBar.text]){
            [newUserArray addObject:u];
        }
    }
    return [newUserArray count];
}

User *u;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *userArray = [User retrieveDataFromNSUserDefaults];
    u = [userArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"mapSegue" sender:self];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    if (cell == nil){
        cell = [[UserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
    }
    
    NSArray *userArray = [User retrieveDataFromNSUserDefaults];
    
    if (isSearching){
        NSMutableArray *newUserArray = [[NSMutableArray alloc]init];
        for (User *u in userArray){
            if ([u.favoriteFruit hasPrefix:_favoriteFruitSearchBar.text]){
                [newUserArray addObject:u];
            }
        }
        userArray = newUserArray;
    }
    
    
    User *u = [userArray objectAtIndex:indexPath.row];
    cell.addressLabel.text = u.address;
    cell.nameLabel.text = [[u.firstName stringByAppendingString:@" "] stringByAppendingString:u.lastName];
    cell.phoneLabel.text = u.phone;
    cell.emailLabel.text = u.email;
    cell.ageLabel.text = [@"Age:" stringByAppendingString:[u.age stringValue]];
    
    if ([u.gender isEqualToString:@"female"]){
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"female-sign" ofType:@"png"];
        cell.genderImageView.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:filePath]];
    }
    
    cell.textLabel.hidden = YES;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MapViewController *mapDispVC = [segue destinationViewController];
    mapDispVC. = u;
}

@end
