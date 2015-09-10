//
//  BookTableViewController.m
//  Exercise2Group7
//
//  Created by Jared Jones on 9/10/15.
//  Copyright © 2015 Jared Jones. All rights reserved.
//

#import "BookTableViewController.h"
#import "Book.h"

@interface BookTableViewController ()

@property (nonatomic, strong) NSMutableArray *bookArray;

@end

@implementation BookTableViewController

- (void)initalizeBookList{
    _bookArray = [[NSMutableArray alloc]init];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"books" ofType:@"txt"];
    NSString *bookListContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *booksLineByLine = [bookListContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for (NSString *str in booksLineByLine){
        NSArray *bookContent = [str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        NSUInteger counter = 4;
        
        NSString *isbn = nil;
        NSString *title = nil;
        NSString *authors = nil;
        NSNumber *category = nil;
        Book *book = nil;
        
        for (NSString *e in bookContent){
            switch (counter--){
                case 4:
                    isbn = e;
                    break;
                case 3:
                    title = e;
                    break;
                case 2:
                    authors = e;
                    break;
                case 1:
                    //0 - programming
                    //1 - science
                    //2 - math
                    //3 - fiction
                    if ([e isEqualToString:@"programming"]){
                        category = [[NSNumber alloc]initWithInteger:0];
                    } else if ([e isEqualToString:@"science"]){
                        category = [[NSNumber alloc]initWithInteger:1];
                    } else if ([e isEqualToString:@"math"]){
                        category = [[NSNumber alloc]initWithInteger:2];
                    } else if ([e isEqualToString:@"fiction"]){
                        category = [[NSNumber alloc]initWithInteger:3];
                    }
                    
                    book = [[Book alloc]initWithStuff:isbn withTitle:title withAuthors:authors withCategory:category];
                    [_bookArray addObject:book];
                    
                    break;
                default:
                    break;
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initalizeBookList];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_bookArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"bookCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
    }
    
    Book *b = [_bookArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [b title];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
