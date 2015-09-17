//
//  User.h
//  Exercise3Group7
//
//  Created by Jared Jones on 9/17/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
- (instancetype)initWithUser: (NSString *)user withPassword: (NSString *)password;
+ (BOOL)doesEmailExist: (NSString*) email;
+ (NSArray*) retrieveDataFromNSUserDefaults;
+ (void)storeDataInNSUserDefaults:(User *)userToStore;
@end
