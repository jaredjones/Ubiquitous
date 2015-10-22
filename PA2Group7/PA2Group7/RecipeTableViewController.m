//
//  RecipeTableViewController.m
//  PA2Group7
//
//  Created by UH Game and Entrepreneurship on 10/22/15.
//  Copyright © 2015 ubicomp7. All rights reserved.
//

#import "RecipeTableViewController.h"

@interface RecipeTableViewController ()

@end

@implementation RecipeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _recipeArray = [[NSMutableArray alloc]init];
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://cpl.uh.edu/courses/ubicomp/api/recipe.php?query=getAll"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *e = nil;
        NSMutableDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
        NSNumber *length = [jsonDictionary objectForKey:@"total"];
        
        
        for (NSUInteger i = 1; i <= [length integerValue]; i++){
            NSMutableDictionary *dic = [jsonDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)i]];
            Recipe *r = [[Recipe alloc]init];
            
            [r setIdentify:[dic objectForKey:@"id"]];
            [r setName:[dic objectForKey:@"name"]];
            [r setDesc:[dic objectForKey:@"description"]];
            [r setLatitude:[dic objectForKey:@"latitude"]];
            [r setLongitude:[dic objectForKey:@"longitude"]];
            [r setPicture1:[dic objectForKey:@"picture1"]];
            [r setPicture2:[dic objectForKey:@"picture2"]];
            [r setPicture3:[dic objectForKey:@"picture3"]];
            
            [_recipeArray addObject:r];
        }
        dispatch_semaphore_signal(sema);
    }];
    [dataTask resume];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    // Do any additional setup after loading the view.
    

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
    return [_recipeArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecipeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
    }
    
    Recipe *r = [_recipeArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [r name];
    cell.textLabel.hidden = NO;
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
