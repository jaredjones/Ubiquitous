//
//  Car.m
//  PA1Group7
//
//  Created by Jared Jones on 9/24/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "Car.h"

@implementation Car

- (instancetype) init{
    NSLog(@"Must use designated init.");
    return nil;
}

- (instancetype) initWithInformation: (NSNumber *)year withVIN: (NSString *)vin withMake: (NSString *)make withModel: (NSString *)model{
    if (self = [super init]){
        _year = year;
        _vin = vin;
        _make = make;
        _model = model;
        return self;
    }
    return nil;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ( self = [super init] ) {
        _year = [aDecoder decodeObjectForKey:@"year"];
        _vin = [aDecoder decodeObjectForKey:@"vin"];
        _make = [aDecoder decodeObjectForKey:@"make"];
        _model = [aDecoder decodeObjectForKey:@"model"];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_year forKey:@"year"];
    [aCoder encodeObject:_vin forKey:@"vin"];
    [aCoder encodeObject:_make forKey:@"make"];
    [aCoder encodeObject:_model forKey:@"model"];
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

+ (void)storeDataInNSUserDefaults:(Car *)carToStore
{
    NSMutableArray *objectArray = [NSMutableArray arrayWithArray:[self retrieveDataFromNSUserDefaults]];
    [objectArray addObject:carToStore];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:objectArray] forKey:@"savedArray"];
}

@end
