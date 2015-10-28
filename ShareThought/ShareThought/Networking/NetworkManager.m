//
//  NetworkManager.m
//  Sharethought
//
//  Created by Jared Jones on 10/12/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "packet.h"

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

+ (id)sharedManager {
    static NetworkManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init{
    if (self = [super init]){
        return self;
    }
    return nil;
}

- (void)connect: (NSString *)host withPort: (NSNumber *)port{
    _host = [host copy];
    _port = [port copy];
    
    //dispatch_queue_t networkQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    _socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:mainQueue];
    
    NSError *error = nil;
    if ( ![_socket connectToHost:_host onPort:[_port unsignedIntegerValue] withTimeout:5.0 error:&error] ){
        NSLog(@"Error Connecting: %@", error);
    }
}

- (void)loginWithEmail: (NSString *)email withPassword: (NSString *)password{
    
    NSString *packetBody = [NSString stringWithFormat:@"%c%s%c%s", (char)email.length, [email cStringUsingEncoding:NSUTF8StringEncoding], (char)password.length, [password cStringUsingEncoding:NSUTF8StringEncoding]];
    NSData *packetBodyData = [packetBody dataUsingEncoding:NSUTF8StringEncoding];
    
    uint64_t finalSize;
    char *packetData;
    NSData *data;
    packetData = ConstructPacket(CMSG_LOGIN, packetBody.length, (char*)[packetBodyData bytes], &finalSize);
    data = [NSData dataWithBytes:packetData length:(uint32_t)finalSize];
    
    [_socket writeData:data withTimeout:-1 tag:0];
    free(packetData);
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"Socket Disconnected");
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"Socket:%@ didConnectToHost:%@ onPort:%hu", sock, host, port);
    
    NSUInteger headerLength = 3;
    [sock readDataToLength:headerLength withTimeout:-1 tag:0];
}

Packet *tmp = nil;
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    if (tmp == nil){
        const void *packet = [data bytes];
        tmp = DecodePacket((void*)packet, [data length]);
        
        if (tmp->LENGTH == 0){
            goto startPacketReading;
        }
        [sock readDataToLength:tmp->LENGTH withTimeout:-1 tag:0];
        
        return;
    }else{
    startPacketReading:
        fflush(stdout);
        uint64_t finalSize;
        char *packetData;
        NSData *data;
        
        switch (tmp->OPCODE) {
            case SMSG_CONNECTED:
                NSLog(@"Connected!");
                break;
                
            case SMSG_KEEP_ALIVE:
                NSLog(@"SMSG_KEEP_ALIVE");
                packetData = ConstructPacket(CMSG_KEEP_ALIVE, 0, NULL, &finalSize);
                data = [NSData dataWithBytes:packetData length:(uint32_t)finalSize];
                
                [sock writeData:data withTimeout:-1 tag:0];
                free(packetData);
                break;
                
            default:
                NSLog(@"Malformed Packet Received!");
                [sock disconnect];
                break;
        }
        
        free(tmp);
        tmp = nil;
        
        //Read next packet
        [sock readDataToLength:3 withTimeout:-1 tag:0];
        return;
    }
    
    //NSString *httpResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"HTTP Response:\n%@", httpResponse);
}

- (GCDAsyncSocket *)getSocket{
    return self.socket;
}
@end