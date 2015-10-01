//
//  User.m
//  Exercise4Group7
//
//  Created by Jared Jones on 10/1/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)init{
    if ( self = [super init]){
        return self;
    }
    return nil;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ( self = [super init] ) {
        _favoriteFruit = [aDecoder decodeObjectForKey:@"favoriteFruit"];
        _address = [aDecoder decodeObjectForKey:@"address"];
        _phone = [aDecoder decodeObjectForKey:@"phone"];
        _email = [aDecoder decodeObjectForKey:@"email"];
        _company = [aDecoder decodeObjectForKey:@"company"];
        _lastName = [aDecoder decodeObjectForKey:@"lastName"];
        _firstName = [aDecoder decodeObjectForKey:@"firstName"];
        _gender = [aDecoder decodeObjectForKey:@"gender"];
        _age = [aDecoder decodeObjectForKey:@"age"];
        _idValue = [aDecoder decodeObjectForKey:@"idValue"];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_favoriteFruit forKey:@"favoriteFruit"];
    [aCoder encodeObject:_address forKey:@"address"];
    [aCoder encodeObject:_phone forKey:@"phone"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_company forKey:@"company"];
    [aCoder encodeObject:_lastName forKey:@"lastName"];
    [aCoder encodeObject:_firstName forKey:@"firstName"];
    [aCoder encodeObject:_gender forKey:@"gender"];
    [aCoder encodeObject:_age forKey:@"age"];
    [aCoder encodeObject:_idValue forKey:@"idValue"];
    // code for other attribute(s)
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
