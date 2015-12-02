//
//  User.h
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/10/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User : NSObject <NSCoding>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *fname;
@property (nonatomic, strong) NSString *lname;
@property (nonatomic, strong) NSString *profileDescription;
@property (nonatomic, strong) NSString *SSO;
@property (nonatomic,strong) UIImage *profilePic;

+ (id)me;
- (instancetype)initWithUser: (NSString *)user withEmail: (NSString *)email withFirstName: (NSString *)firstName withLastName: (NSString *)lastName withProfileDesc: (NSString *) pDesc withProfilePic: (UIImage *) profilePic;
+ (NSArray *)convertPacketDataToStringArray: (NSData *)data;
+ (BOOL)doesEmailExist: (NSString*) email;
+ (NSArray*) retrieveDataFromNSUserDefaults;
+ (void)storeDataInNSUserDefaults:(User *)userToStore;
@end