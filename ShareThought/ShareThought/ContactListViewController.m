//
//  ContactListViewController.m
//  ShareThought
//
//  Created by Aidaly Santamaria on 11/3/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "ContactListViewController.h"
#import "ContactList.h"

@interface ContactListViewController ()
@property ContactList *contactList;
@end

@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _contactList = [[ContactList alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.view = _contactList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
