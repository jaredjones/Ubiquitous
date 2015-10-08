//
//  User.h
//  Exercise4Group7
//
//  Created by Jared Jones on 10/1/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property (nonatomic, strong) NSString *favoriteFruit;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSString *idValue;

+ (void)storeDataInNSUserDefaults:(User *)userToStore;
+ (NSArray *)retrieveDataFromNSUserDefaults;
@end
