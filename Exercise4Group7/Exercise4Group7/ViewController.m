//
//  ViewController.m
//  Exercise4Group7
//
//  Created by Jared Jones on 10/1/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *showTableButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_showTableButton setEnabled:NO];
    
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://beta.json-generator.com/api/json/get/NyH0iiA0"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *e = nil;
        NSArray *JSONarray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
        for (NSUInteger i = 0; i < [JSONarray count]; i++){
            User *tmp = [[User alloc] init];
            tmp.favoriteFruit = [[JSONarray objectAtIndex:i]objectForKey:@"favoriteFruit"];
            tmp.address = [[JSONarray objectAtIndex:i]objectForKey:@"address"];
            tmp.phone = [[JSONarray objectAtIndex:i]objectForKey:@"phone"];
            tmp.email = [[JSONarray objectAtIndex:i]objectForKey:@"email"];
            tmp.company = [[JSONarray objectAtIndex:i]objectForKey:@"company"];
            tmp.lastName = [[[JSONarray objectAtIndex:i]objectForKey:@"name"] objectForKey:@"last"];
            tmp.firstName = [[[JSONarray objectAtIndex:i]objectForKey:@"name"] objectForKey:@"first"];
            tmp.gender = [[JSONarray objectAtIndex:i]objectForKey:@"gender"];
            tmp.age = [[JSONarray objectAtIndex:i]objectForKey:@"age"];
            tmp.idValue = [[JSONarray objectAtIndex:i]objectForKey:@"_id"];
            [User storeDataInNSUserDefaults:tmp];
            
            NSLog(@"%lu %lu", (unsigned long)i+1, (unsigned long)[JSONarray count]);
            if ((i + 1) == [JSONarray count]){
                [_showTableButton setEnabled:YES];
            }
        }
    }];
    [dataTask resume];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showTablePressed:(id)sender {
    [self performSegueWithIdentifier:@"showTableSegue" sender:self];
}

@end
