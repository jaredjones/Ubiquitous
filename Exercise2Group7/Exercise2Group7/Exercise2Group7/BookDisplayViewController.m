//
//  BookDisplayViewController.m
//  Exercise2Group7
//
//  Created by Jared Jones on 9/10/15.
//  Copyright © 2015 Jared Jones. All rights reserved.
//

#import "BookDisplayViewController.h"

@interface BookDisplayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *isbnLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation BookDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
    [_isbnLabel setText:[_bookData isbn]];
    [_titleLabel setText:[_bookData title]];
    [_authorLabel setText:[_bookData authors]];
    [_categoryLabel setText:[Book getCategoryGivenID:[[_bookData category] integerValue]]];
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
