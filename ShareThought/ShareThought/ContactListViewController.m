//
//  ContactListViewController.m
//  ShareThought
//
//  Created by Aidaly Santamaria on 11/3/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "ContactListViewController.h"
#import "User.h"
#import "ContactListTableViewCell.h"

@interface ContactListViewController () <ContactListTableCellDelegate>

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

    [self initTableData];
    self.view.backgroundColor = [UIColor colorWithRed:74.0/255.0f green:71.0/255.0f blue:79.0/255.0f alpha:0.0f]; // DOES NOTHING
}

-(void)initTableData {
    _contacts = [[NSMutableArray alloc] init];          //load the contacts with dummy data
    
    User *user = [[User alloc] initWithUser:@"user1@mail.com" withPassword:@"password1" withFirstName:@"Alisa" withLastName:@"Tucker" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user2@mail.com" withPassword:@"password2" withFirstName:@"Isaac" withLastName:@"Ford" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user3@mail.com" withPassword:@"password3" withFirstName:@"Owen" withLastName:@"Mitchell" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user4@mail.com" withPassword:@"password4" withFirstName:@"McKenzie" withLastName:@"Mitchell" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user5@mail.com" withPassword:@"password5" withFirstName:@"Stephanie" withLastName:@"Welch" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user6@mail.com" withPassword:@"password6" withFirstName:@"Kylie" withLastName:@"Oliver" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user7" withPassword:@"password7" withFirstName:@"Desirae" withLastName:@"Fleming" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user8" withPassword:@"password8" withFirstName:@"Thomas" withLastName:@"Everett" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user9" withPassword:@"password9" withFirstName:@"Omar" withLastName:@"Wilson" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user10" withPassword:@"password10" withFirstName:@"Harding" withLastName:@"Leach" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user11" withPassword:@"password11" withFirstName:@"Brody" withLastName:@"Eaton" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user12" withPassword:@"password12" withFirstName:@"David" withLastName:@"Stuart" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user13" withPassword:@"password13" withFirstName:@"Mark" withLastName:@"Beach" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    user = [[User alloc] initWithUser:@"user14" withPassword:@"password14" withFirstName:@"Michael" withLastName:@"Copeland" withProfileDesc:@"desc"];
    [_contacts addObject:user];
    
    //sort contacts by last name and then first name
    NSSortDescriptor *lnameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lname" ascending:YES];
    NSSortDescriptor *fnameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fname" ascending:YES];
    NSArray *descriptors = @[lnameDescriptor, fnameDescriptor];
    
    [_contacts sortUsingDescriptors:descriptors];
    _searchResults = [[NSMutableArray alloc] initWithArray:_contacts];
    
    
    [self setSectionTitles:_contactSectionTitles];
    
    _contactIndexTitles = [NSArray arrayWithObjects: UITableViewIndexSearch, @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTitleLabel:(UILabel *)titleLabel {
    titleLabel.text = @"Contacts";
    titleLabel.textColor = [UIColor colorWithRed:77/255.0f green:201/255.0f blue:180/255.0 alpha:1.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel = titleLabel;
}

-(void)setSearchBar:(UISearchBar *)searchBar {
    searchBar.placeholder = @"Search Contacts";
    searchBar.tintColor = [UIColor colorWithRed:77/255.0f green:201/255.0f blue:180/255.0f alpha:1.0f];
    searchBar.barTintColor = [UIColor colorWithRed:37/255.0f green:42/255.0f blue:49/255.0f alpha:0.0f];
    
    //[searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"555555"] forState:UIControlStateNormal];
    
    for (UIView *subView in searchBar.subviews) {
        for(id field in subView.subviews){
            if ([field isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)field;
                //[textField setBackgroundColor:[UIColor grayColor]];
                [textField setBackgroundColor:[UIColor colorWithRed:30/255.0f green:31/255.0f blue:33/255.0 alpha:1.0f]];
            }
        }
    }
    
    for (id object in [[[searchBar subviews] objectAtIndex:0] subviews])
    {
        if ([object isKindOfClass:[UITextField class]])
        {
            UITextField *textFieldObject = (UITextField *)object;
            

            textFieldObject.layer.borderColor = [[UIColor colorWithRed:77/255.0f green:201/255.0f blue:180/255.0 alpha:1.0f]CGColor];
            textFieldObject.layer.cornerRadius=6.0f;
            textFieldObject.layer.masksToBounds = YES;
            textFieldObject.layer.borderWidth = 2.0;
            textFieldObject.textColor = [UIColor colorWithRed:77/255.0f green:201/255.0f blue:180/255.0f alpha:1.0f];
            break;
        }
    }
    
    _searchBar = searchBar;
}

-(void)setContactTableView:(UITableView *)contactTableView {
    contactTableView.backgroundColor = [UIColor darkGrayColor];
    
    _contactTableView = contactTableView;
}

-(void)setSectionTitles:(NSMutableArray *)sectionTitles {
    _contactSectionTitles = [[NSMutableArray alloc] init];
    
    //get first letter of lastname of each contact, if it has not been added as a section title before then do so
    NSString *letterString = nil;
    for (_currentContact in _searchResults) {
        unichar letter = [_currentContact.lname characterAtIndex:0];
        letterString = [NSString stringWithCharacters:&letter length:1];
        if (![_contactSectionTitles containsObject:letterString]) {
            [_contactSectionTitles addObject:letterString];
        }
    }
}

-(NSUInteger)findIndexOfContactWithName:(NSString *)contactName {
    NSUInteger index = 0;
    NSArray *name = [contactName componentsSeparatedByString:@" "];
    for (int i=0; i < [_contacts count]; i++) {
        User *u = [_contacts objectAtIndex:i];
        if ([u.fname isEqualToString:[name objectAtIndex:0]] && [u.lname isEqualToString:[name objectAtIndex:1]]) {
            index = i;
        }
    }
    return index;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma Table View Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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
    ContactListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell" forIndexPath:indexPath];
    
    if (cell == nil ) {
        cell = [[ContactListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contactCell"];
    }
    
    NSString *sectionTitle = [_contactSectionTitles objectAtIndex:indexPath.section];
    NSString *letterString = nil;
    NSMutableArray *users = [[NSMutableArray alloc] init];
    
    //load the cell in the corresponding section
    for (_currentContact in _searchResults) {
        unichar letter = [_currentContact.lname characterAtIndex:0];
        letterString = [NSString stringWithCharacters:&letter length:1];
        if ([letterString isEqualToString:sectionTitle]) {
            [users addObject:_currentContact];
        }
    }
    User *u = [users objectAtIndex:indexPath.row];
    cell.contactName = [u.fname stringByAppendingFormat:@" %@", u.lname];
    cell.contactDesc = u.profileDescription;
    cell.delegate = self;
    
    //In order to change the color go to the ContactTabelViewCell.m 
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
    [self setSectionTitles:_contactSectionTitles];
    [_contactTableView reloadData];
}

#pragma Contact List Table Cell Delegate

-(void)deleteButtonActionForContact:(NSString *)contactName {
    NSUInteger index = [self findIndexOfContactWithName:contactName];
    
    //update model
    [_contacts removeObjectAtIndex:index];
    [_searchResults removeAllObjects];
    [_searchResults addObjectsFromArray:_contacts];
    [self setSectionTitles:_contactSectionTitles];
    
    //update view
    [_contactTableView reloadData];
}

-(void)editButtonActionForContact:(NSString *)contactName {
    NSLog(@"edit button for %@", contactName);                     //need to implement editing
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
