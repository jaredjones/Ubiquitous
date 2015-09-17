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

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ( self = [super init] ) {
        _email = [aDecoder decodeObjectForKey:@"email"];
        _password = [aDecoder decodeObjectForKey:@"password"];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_password forKey:@"password"];
    // code for other attribute(s)
}

+ (BOOL)doesEmailExist: (NSString *) email{
    NSArray *userArray = [User retrieveDataFromNSUserDefaults];
    for (User *u in userArray){
        if ([[u email] isEqualToString:email]){
            return YES;
        }
    }
    return NO;
}

+ (BOOL)emailCredentialsValid: (NSString *)email withPassword: (NSString *)password{
    NSArray *userArray = [User retrieveDataFromNSUserDefaults];
    for (User *u in userArray){
        if ([[u email] isEqualToString:email]){
            if ([[u password] isEqualToString:password]){
                return YES;
            }
        }
    }
    return NO;
}

+ (NSArray *)retrieveDataFromNSUserDefaults {
    NSMutableArray *objectArray = [NSMutableArray new];
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"savedArray"];
    
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
            objectArray = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        else
            objectArray = [[NSMutableArray alloc] init];
    }
    return objectArray;
}

+ (void)storeDataInNSUserDefaults:(User *)userToStore
{
    NSMutableArray *objectArray = [NSMutableArray arrayWithArray:[self retrieveDataFromNSUserDefaults]];
    [objectArray addObject:userToStore];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:objectArray] forKey:@"savedArray"];
}

@end
