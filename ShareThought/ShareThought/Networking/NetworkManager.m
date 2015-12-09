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
#import "User.h"
#import "NoNetworkViewController.h"

@interface NetworkManager()
{
    
}

@property (nonatomic, strong) GCDAsyncSocket *socket;

@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSNumber *port;

@property (nonatomic, strong) NoNetworkViewController *noNetworkVC;

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
        _noNetworkVC = nil;
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
    if ( ![_socket connectToHost:host onPort:[_port unsignedIntegerValue] withTimeout:2.0 error:&error] ){
        NSLog(@"Error Connecting: %@", error);
    }
}

- (void)loginWithEmail: (NSString *)email withPassword: (NSString *)password{
    
    NSString *packetBody = [NSString stringWithFormat:@"%c%s%c%s", (char)email.length, [email cStringUsingEncoding:NSUTF8StringEncoding], (char)password.length, [password cStringUsingEncoding:NSUTF8StringEncoding]];
    NSData *packetBodyData = [packetBody dataUsingEncoding:NSUTF8StringEncoding];
    
    uint64_t finalSize;
    unsigned char *packetData;
    NSData *data;
    packetData = ConstructPacket(CMSG_LOGIN, packetBody.length, (unsigned char*)[packetBodyData bytes], &finalSize);
    data = [NSData dataWithBytes:packetData length:(uint32_t)finalSize];
    
    [_socket writeData:data withTimeout:-1 tag:0];
    free(packetData);
}

- (void)registerWithEmail: (NSString *)email withPassword: (NSString *)password withFirstName: (NSString *)fName withLastName: (NSString *)lName withAboutYou: (NSString *)aboutYou withUserName:(NSString *)userName{
    NSString *packetBody = [NSString stringWithFormat:@"%c%s%c%s%c%s%c%s%c%s%c%s",
                            (char)email.length, [email cStringUsingEncoding:NSUTF8StringEncoding],
                            (char)password.length, [password cStringUsingEncoding:NSUTF8StringEncoding],
                            (char)fName.length, [fName cStringUsingEncoding:NSUTF8StringEncoding],
                            (char)lName.length, [lName cStringUsingEncoding:NSUTF8StringEncoding],
                            (char)aboutYou.length, [aboutYou cStringUsingEncoding:NSUTF8StringEncoding],
                            (char)userName.length, [userName cStringUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *packetBodyData = [packetBody dataUsingEncoding:NSUTF8StringEncoding];
    
    uint64_t finalSize;
    unsigned char *packetData;
    NSData *data;
    packetData = ConstructPacket(CMSG_REGISTER, packetBody.length, (unsigned char*)[packetBodyData bytes], &finalSize);
    data = [NSData dataWithBytes:packetData length:(uint32_t)finalSize];
    
    [_socket writeData:data withTimeout:-1 tag:0];
    free(packetData);
}

- (void)logout{
    uint64_t finalSize;
    unsigned char *packetData;
    NSData *data;
    packetData = ConstructPacket(CMSG_LOGOUT, 0, NULL, &finalSize);
    data = [NSData dataWithBytes:packetData length:(uint32_t)finalSize];
    
    [_socket writeData:data withTimeout:-1 tag:0];
    free(packetData);
}

- (void)deleteAccount{
    uint64_t finalSize;
    unsigned char *packetData;
    NSData *data;
    packetData = ConstructPacket(CMSG_DELETE_ACCOUNT, 0, NULL, &finalSize);
    data = [NSData dataWithBytes:packetData length:(uint32_t)finalSize];
    
    [_socket writeData:data withTimeout:-1 tag:0];
    free(packetData);
}

- (void)addContact: (NSString *)userName{
    NSString *packetBody = [NSString stringWithFormat:@"%c%s", (char)userName.length, [userName cStringUsingEncoding:NSUTF8StringEncoding]];
    NSData *packetBodyData = [packetBody dataUsingEncoding:NSUTF8StringEncoding];
    
    uint64_t finalSize;
    unsigned char *packetData;
    NSData *data;
    packetData = ConstructPacket(CMSG_ADD_CONTACT, packetBody.length, (unsigned char*)[packetBodyData bytes], &finalSize);
    data = [NSData dataWithBytes:packetData length:(uint32_t)finalSize];
    
    [_socket writeData:data withTimeout:-1 tag:0];
    free(packetData);
}

- (void)deleteContact: (NSString *)userName{
    NSString *packetBody = [NSString stringWithFormat:@"%c%s", (char)userName.length, [userName cStringUsingEncoding:NSUTF8StringEncoding]];
    NSData *packetBodyData = [packetBody dataUsingEncoding:NSUTF8StringEncoding];
    
    uint64_t finalSize;
    unsigned char *packetData;
    NSData *data;
    packetData = ConstructPacket(CMSG_DELETE_CONTACT, packetBody.length, (unsigned char*)[packetBodyData bytes], &finalSize);
    data = [NSData dataWithBytes:packetData length:(uint32_t)finalSize];
    
    [_socket writeData:data withTimeout:-1 tag:0];
    free(packetData);
}

- (void)grabContacts{
    uint64_t finalSize;
    unsigned char *packetData;
    NSData *data;
    packetData = ConstructPacket(CMSG_GRAB_CONTACTS, 0, NULL, &finalSize);
    data = [NSData dataWithBytes:packetData length:(uint32_t)finalSize];
    
    [_socket writeData:data withTimeout:-1 tag:0];
    free(packetData);
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"Disconnected");
    
    #define ROOTVIEW [[[UIApplication sharedApplication] keyWindow] rootViewController]
    
    if (_noNetworkVC == nil){
        _noNetworkVC = [[NoNetworkViewController alloc]init];
        [ROOTVIEW presentViewController:_noNetworkVC animated:YES completion:^{}];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self connect:_host withPort:_port];
        });
    });
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"Socket:%@ didConnectToHost:%@ onPort:%hu", sock, host, port);
    
    NSUInteger headerLength = 3;
    [sock readDataToLength:headerLength withTimeout:-1 tag:0];
}

- (void) nilOutDisconnectedVC
{
    [_noNetworkVC dismissViewControllerAnimated:YES completion:^{
       _noNetworkVC = nil;
    }];
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
        unsigned char *packetData;
        NSData *wData;
        
        NSArray *arr;
        
        switch (tmp->OPCODE) {
            case SMSG_CONNECTED:
                NSLog(@"Connected!");
                [self nilOutDisconnectedVC];
                break;
                
            case SMSG_KEEP_ALIVE:
                NSLog(@"SMSG_KEEP_ALIVE");
                packetData = ConstructPacket(CMSG_KEEP_ALIVE, 0, NULL, &finalSize);
                wData = [NSData dataWithBytes:packetData length:(uint32_t)finalSize];
                
                [sock writeData:wData withTimeout:-1 tag:0];
                free(packetData);
                break;
            case SMSG_SUCCESSFUL_LOGIN:
                NSLog(@"SMSG_SUCCESSFUL_LOGIN");
                
                arr = [User convertPacketDataToStringArray:data];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoggedInNotification" object:
                 self userInfo:@{@"SSO":[arr objectAtIndex:0],
                                 @"User": [[User alloc]
                                           initWithUser:[arr objectAtIndex:1]
                                           withEmail:[arr objectAtIndex:2]
                                           withFirstName:[arr objectAtIndex:3]
                                           withLastName:[arr objectAtIndex:4]
                                           withProfileDesc:[arr objectAtIndex:5]
                                           withProfilePic:nil]}];
                break;
            case SMSG_UNSUCCESSFUL_LOGIN:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginFailureInNotification" object:self];
                break;
            case SMSG_ACCOUNT_CREATED:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistrationNotification" object:self];
                break;
            case SMSG_ACCOUNT_ALREADY_EXISTS:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistrationNotificationAlreadyExists" object:self];
                break;
            case SMSG_SEND_CONTACTS:
                NSLog(@"SMSG_SEND_CONTACTS");
                //Loool
                if (true){
                    
                    char *bytes = (char*)[data bytes];
                    int numberOfContacts = *(bytes);
                    bytes+=1;
                    if (numberOfContacts < 1)
                        break;
                    arr = [User convertPacketDataToStringArray:[NSData dataWithBytes:bytes length:[data length] - 1]];
                    
                    NSMutableArray *userArray = [[NSMutableArray alloc]init];
                    for (NSUInteger i = 0; i < numberOfContacts*4; i+=4){
                        User *u = [[User alloc]initWithUser:[arr objectAtIndex:i]
                                                  withEmail:nil
                                              withFirstName:[arr objectAtIndex:i+1]
                                               withLastName:[arr objectAtIndex:i+2]
                                            withProfileDesc:[arr objectAtIndex:i+3]
                                             withProfilePic:nil];
                        [userArray addObject:u];
                    }
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ContactsReceived"
                                                                        object:self
                                                                      userInfo:@{@"Contacts": userArray}];
                }
                
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