//
//  NetworkManager.h
//  Sharethought
//
//  Created by Jared Jones on 10/12/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CocoaAsyncSocket.h"

@interface NetworkManager : NSObject <GCDAsyncSocketDelegate>

+ (id)sharedManager;
- (void)loginWithEmail: (NSString *)email withPassword: (NSString *)password;
- (void)registerWithEmail: (NSString *)email withPassword: (NSString *)password withFirstName: (NSString *)fName withLastName: (NSString *)lName;
- (void)connect: (NSString *)host withPort: (NSNumber *)port;
- (GCDAsyncSocket *)getSocket;
@end
