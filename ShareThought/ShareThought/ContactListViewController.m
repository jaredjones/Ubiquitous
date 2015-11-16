//
//  ContactListViewController.m
//  ShareThought
//
//  Created by Aidaly Santamaria on 11/3/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "ContactListViewController.h"

@interface ContactListViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *contactTableView;

@property (strong, nonatomic) NSArray *contacts;                    //for testing need to implement for users
@property (strong, nonatomic) NSMutableArray *searchResults;        //for testing need to implement for users
@end

@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _contacts = [[NSArray alloc] initWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten", nil];
    _searchResults = [[NSMutableArray alloc] initWithArray:_contacts];
    
    self.view.backgroundColor = [UIColor colorWithRed:74.0/255.0f green:71.0/255.0f blue:79.0/255.0f alpha:0.0f];
}

- (void)didReceiveMemoryWarning {
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
    searchBar.text = @"Search for Contact or Tag";
    searchBar.barTintColor = [UIColor colorWithRed:116.0/255.0f green:114.0/255.0f blue:120.0/255.0 alpha:0.0f];
    
    _searchBar = searchBar;
}

-(void)setContactTableView:(UITableView *)contactTableView {
    contactTableView.backgroundColor = [UIColor darkGrayColor];
    
    _contactTableView = contactTableView;
}

#pragma Table View Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    
    if (cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contactCell"];
    }
    
    cell.textLabel.text = [_searchResults objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor darkGrayColor];
    return cell;
}

#pragma Search Methods

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0) {
        [_searchResults removeAllObjects];
        [_searchResults addObjectsFromArray:_contacts];
    }
    else {
        [_searchResults removeAllObjects];
        for (NSString *string in _contacts) {
            NSRange r = [string rangeOfString:searchText  options:NSCaseInsensitiveSearch];
            if (r.location != NSNotFound) {
                [_searchResults addObject:string];
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
