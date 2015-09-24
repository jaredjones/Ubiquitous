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
        return self;
    }
    return nil;
}

@end
