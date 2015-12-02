//
//  User.h
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/10/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *fname;
@property (nonatomic, strong) NSString *lname;
@property (nonatomic, strong) NSString *profileDescription;


- (instancetype)initWithUser: (NSString *)user withEmail: (NSString *)email withFirstName: (NSString *)firstName withLastName: (NSString *)lastName withProfileDesc: (NSString *) pDesc;
+ (BOOL)doesEmailExist: (NSString*) email;
+ (NSArray*) retrieveDataFromNSUserDefaults;
+ (void)storeDataInNSUserDefaults:(User *)userToStore;
@end
