//
//  User.m
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/10/15.
//  Copyright © 2015 Team7. All rights reserved.
//
#import "User.h"

@implementation User

- (instancetype)init{
    NSLog(@"Please instantiate with initWithUser:");
    return nil;
}

- (instancetype)initWithUser: (NSString *)user withPassword: (NSString *)password withFirstName: (NSString *)firstName withLastName: (NSString *)lastName withProfileDesc: (NSString *) prDesc{
    if (self = [super init]){
        _email = user;
        _password = password;
        _fname = firstName;
        _lname = lastName;
        _profileDescription = prDesc;
        return self;
    }
    return nil;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ( self = [super init] ) {
        _email = [aDecoder decodeObjectForKey:@"email"];
        _password = [aDecoder decodeObjectForKey:@"password"];
        _fname = [aDecoder decodeObjectForKey:@"fname"];;
        _lname = [aDecoder decodeObjectForKey:@"lname"];;
        _profileDescription = [aDecoder decodeObjectForKey:@"profileDescription"];;
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_fname forKey:@"fname"];
    [aCoder encodeObject:_lname forKey:@"lname"];
    [aCoder encodeObject:_profileDescription forKey:@"profileDescription"];
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
