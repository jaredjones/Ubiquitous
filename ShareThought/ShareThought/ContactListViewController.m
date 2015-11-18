//
//  ContactListViewController.m
//  ShareThought
//
//  Created by Aidaly Santamaria on 11/3/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "ContactListViewController.h"
#import "User.h"

@interface ContactListViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *contactTableView;

@property (nonatomic, strong) NSMutableArray *contacts;
@property (nonatomic, strong) User *currentContact;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) NSMutableArray *contactSectionTitles;
@property (nonatomic, strong) NSArray *contactIndexTitles;

@end

@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initTableData];
    self.view.backgroundColor = [UIColor colorWithRed:74.0/255.0f green:71.0/255.0f blue:79.0/255.0f alpha:0.0f];
}

-(void)initTableData {
    _contacts = [[NSMutableArray alloc] init];          //needs to connect to database
    
    
    _contactSectionTitles = [[NSMutableArray alloc] init];
    
    NSString *letterString = nil;
    if ([_contacts count] != 0) {
        for (_currentContact in _contacts) {
            unichar letter = [_currentContact.lname characterAtIndex:0];
            letterString = [NSString stringWithCharacters:&letter length:1];
            if (![_contactSectionTitles containsObject:letterString]) {
                [_contactSectionTitles addObject:letterString];
            }
        }
    }
    
    _contactIndexTitles = [NSArray arrayWithObjects: UITableViewIndexSearch, @"#", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    _searchResults = [[NSMutableArray alloc] initWithArray:_contacts];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTitleLabel:(UILabel *)titleLabel {
    titleLabel.text = @"Contacts";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    _titleLabel = titleLabel;
}

-(void)setSearchBar:(UISearchBar *)searchBar {
    searchBar.placeholder = @"Search for Contact or Tag";
    searchBar.barTintColor = [UIColor colorWithRed:116.0/255.0f green:114.0/255.0f blue:120.0/255.0 alpha:0.0f];
    
    _searchBar = searchBar;
}

-(void)setContactTableView:(UITableView *)contactTableView {
    contactTableView.backgroundColor = [UIColor darkGrayColor];
    
    _contactTableView = contactTableView;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma Table View Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {      //sections need to hide when searching
    return [_contactSectionTitles count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_contactSectionTitles objectAtIndex:section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionTitle = [_contactSectionTitles objectAtIndex:section];
    
    NSInteger counter = 0;
    NSString *letterString = nil;
    for (_currentContact in _searchResults) {
        unichar letter = [_currentContact.lname characterAtIndex:0];
        letterString = [NSString stringWithCharacters:&letter length:1];
        if ([letterString isEqualToString:sectionTitle]) {
            counter++;
        }
    }
    return counter;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    
    if (cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contactCell"];
    }
    
    NSString *sectionTitle = [_contactSectionTitles objectAtIndex:indexPath.section];
    NSString *letterString = nil;
    NSMutableArray *users = [[NSMutableArray alloc] init];
    
    for (_currentContact in _searchResults) {
        unichar letter = [_currentContact.lname characterAtIndex:0];
        letterString = [NSString stringWithCharacters:&letter length:1];
        if ([letterString isEqualToString:sectionTitle]) {
            [users addObject:_currentContact];
        }
    }
    User *u = [users objectAtIndex:indexPath.row];
    cell.textLabel.text = [u.fname stringByAppendingFormat:@" %@", u.lname];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor darkGrayColor];
    
    return cell;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([_searchBar.text length] == 0) {
        return _contactIndexTitles;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [_contactSectionTitles indexOfObject:title];
}

#pragma Search Methods

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0) {
        [_searchResults removeAllObjects];
        [_searchResults addObjectsFromArray:_contacts];
    }
    else {
        [_searchResults removeAllObjects];
        for (_currentContact in _contacts) {
            NSRange f = [_currentContact.fname rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange l = [_currentContact.lname rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (f.location != NSNotFound || l.location != NSNotFound) {
                [_searchResults addObject:_currentContact];
            }
        }
    }
    [_contactTableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
