//
//  CarTableViewController.m
//  PA1Group7
//
//  Created by Jared Jones on 9/24/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "CarTableViewController.h"
#import "Car.h"
#import "CarDetailViewController.h"

@interface CarTableViewController ()
@property (nonatomic, strong) Car *car;
@end

@implementation CarTableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *carArray = [Car retrieveDataFromNSUserDefaults];
    return [carArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"carCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
    }
    
    NSArray *carArray = [Car retrieveDataFromNSUserDefaults];
    
    /*NSMutableArray *books = [[NSMutableArray alloc]init];
    for (Book *b in _bookArray){
        if ( [[b category] integerValue] == indexPath.section)
            [books addObject:b];
    }*/
    
    /*Book *b = [books objectAtIndex:indexPath.row];
    cell.textLabel.text = [b title];
    */
    
    
    Car *c = [carArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [[[c make] stringByAppendingString:@", "] stringByAppendingString:[c model]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *carArray = [Car retrieveDataFromNSUserDefaults];
    /*NSMutableArray *books = [[NSMutableArray alloc]init];
    for (Book *b in _bookArray){
        if ( [[b category] integerValue] == indexPath.section)
            [books addObject:b];
    }
    
    Book *b = [books objectAtIndex:indexPath.row];
    
    */
    _car = [carArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"carDetailSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CarDetailViewController *DestinationVC = [segue destinationViewController];
    DestinationVC.car = _car;
}

@end
