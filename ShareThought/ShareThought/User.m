//
//  User.m
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/10/15.
//  Copyright © 2015 Team7. All rights reserved.
//
#import "User.h"

@implementation User

+ (id)me {
    static User *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init{
    if (self = [super init]){
    }
    return self;
}

- (instancetype)initWithUser: (NSString *)user withEmail: (NSString *)email withFirstName: (NSString *)firstName withLastName: (NSString *)lastName withProfileDesc: (NSString *) pDesc withProfilePic:(UIImage *)profilePic{
    if (self = [super init]){
        _email = email;
        _username = user;
        _fname = firstName;
        _lname = lastName;
        _profileDescription = pDesc;
        _profilePic = nil;
        return self;
    }
    return nil;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ( self = [super init] ) {
        _username = [aDecoder decodeObjectForKey:@"username"];
        _email = [aDecoder decodeObjectForKey:@"email"];
        _fname = [aDecoder decodeObjectForKey:@"fname"];;
        _lname = [aDecoder decodeObjectForKey:@"lname"];;
        _profileDescription = [aDecoder decodeObjectForKey:@"profileDescription"];;
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_fname forKey:@"fname"];
    [aCoder encodeObject:_lname forKey:@"lname"];
    [aCoder encodeObject:_profileDescription forKey:@"profileDescription"];
}

+ (NSArray *)convertPacketDataToStringArray:(NSData *)data{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < [data length];){
        char* loc = (char*)[data bytes];
        NSUInteger len = *(loc + i);
        
        char *str = malloc(len+1);
        strncpy(str, (loc + i + 1), len);
        *(str + len) = 0;
        
        [arr addObject:[NSString stringWithUTF8String:str]];
        free(str);
        i+=len +1;
    }
    return arr;
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
