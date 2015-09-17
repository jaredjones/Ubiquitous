//
//  User.m
//  Exercise3Group7
//
//  Created by Jared Jones on 9/17/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)init{
    NSLog(@"Please instantiate with initWithUser:");
    return nil;
}

- (instancetype)initWithUser: (NSString *)user withPassword: (NSString *)password{
    if (self = [super init]){
        _email = user;
        _password = password;
        return self;
    }
    return nil;
}

@end
