//
//  NetworkManager.m
//  Sharethought
//
//  Created by Jared Jones on 10/12/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "CocoaAsyncSocket.h"

#import "NetworkManager.h"

@interface NetworkManager()
{
}

@property (nonatomic, strong) GCDAsyncSocket *socket;

@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSNumber *port;

@end

@implementation NetworkManager

- (instancetype)init{
    NSLog(@"You must initalize Network Manager with initWithHost: withPort:");
    return nil;
}

- (instancetype)initWithHost: (NSString *)host withPort: (NSNumber *)port{
    if (self = [super init]){
        _host = [host copy];
        _port = [port copy];
        
        //dispatch_queue_t networkQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        
        _socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:mainQueue];
        
        NSError *error = nil;
        if ( ![_socket connectToHost:_host onPort:[_port unsignedShortValue] error:&error] ){
            NSLog(@"Error Connecting: %@", error);
        }
        
        return self;
    }
    return nil;
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"Socket:%@ didConnectToHost:%@ onPort:%hu", sock, host, port);
    
    NSString *requestStr = [NSString stringWithFormat:@"GET / HTTP/1.1\r\nHost: %@\r\n\r\n", @"uvora.com"];
    NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [sock writeData:requestData withTimeout:-1 tag:0];
    [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *httpResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"HTTP Response:\n%@", httpResponse);
}
@end