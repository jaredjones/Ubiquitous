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
- (instancetype)initWithHost: (NSString *)host withPort: (NSNumber *)port;
@end
