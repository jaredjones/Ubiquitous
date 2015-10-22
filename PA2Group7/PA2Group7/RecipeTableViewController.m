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
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://cpl.uh.edu/courses/ubicomp/api/recipe.php?query=getAll"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *e = nil;
        NSArray *JSONarray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
        for (NSUInteger i = 0; i < [JSONarray count]; i++){
            Recipe *tmp = [[Recipe alloc] init];
            /*tmp.favoriteFruit = [[JSONarray objectAtIndex:i]objectForKey:@"identify"];
            tmp.address = [[JSONarray objectAtIndex:i]objectForKey:@"address"];
            tmp.phone = [[JSONarray objectAtIndex:i]objectForKey:@"phone"];
            tmp.email = [[JSONarray objectAtIndex:i]objectForKey:@"email"];
            tmp.company = [[JSONarray objectAtIndex:i]objectForKey:@"company"];
            tmp.lastName = [[[JSONarray objectAtIndex:i]objectForKey:@"name"] objectForKey:@"last"];
            tmp.firstName = [[[JSONarray objectAtIndex:i]objectForKey:@"name"] objectForKey:@"first"];
            tmp.gender = [[JSONarray objectAtIndex:i]objectForKey:@"gender"];
            tmp.age = [[JSONarray objectAtIndex:i]objectForKey:@"age"];
            tmp.idValue = [[JSONarray objectAtIndex:i]objectForKey:@"_id"];
             */
            
            /*if ((i + 1) == [JSONarray count]){
                [_showTableButton setUserInteractionEnabled:YES];
            }*/
        }
    }];
    [dataTask resume];
    // Do any additional setup after loading the view.
    
    
    
    
    // Do any additional setup after loading the view.œå
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
