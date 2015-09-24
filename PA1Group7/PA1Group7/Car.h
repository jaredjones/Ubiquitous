//
//  Car.h
//  PA1Group7
//
//  Created by Jared Jones on 9/24/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject<NSCoding>

@property (nonatomic, strong) NSNumber *year;
@property (nonatomic, strong) NSString *vin;
@property (nonatomic, strong) NSString *make;
@property (nonatomic, strong) NSString *model;

+ (void)storeDataInNSUserDefaults:(Car *)carToStore;
+ (NSArray *)retrieveDataFromNSUserDefaults;
+ (BOOL)doesCarAlreadyExist: (Car *)c;
- (instancetype) initWithInformation: (NSNumber *)year withVIN: (NSString *)vin withMake: (NSString *)make withModel: (NSString *)model;
@end
