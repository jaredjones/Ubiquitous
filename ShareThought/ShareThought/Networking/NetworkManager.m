//
//  NetworkManager.m
//  Sharethought
//
//  Created by Jared Jones on 10/12/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager()
{
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    NSMutableData *outputData;
}

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
        
        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;
        
        CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, [port unsignedIntValue], &readStream, &writeStream);
        
        inputStream = (__bridge NSInputStream *)readStream;
        outputStream = (__bridge NSOutputStream *)writeStream;
        
        [inputStream setDelegate:self];
        [outputStream setDelegate:self];
        
        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        
        [inputStream open];
        [outputStream open];
        
        return self;
    }
    return nil;
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    
    NSString *response;
    NSData *data;
    NSString *tmp;
    
    switch (eventCode) {
            
        case NSStreamEventOpenCompleted:
            NSLog(@"TCP Client - Stream Opened!");
            tmp = @"GET / HTTP/1.1\nHost: google.com\nCache-Control: no-cache\nConnection: close\nContent-Type: text/html\n";
            
            response  = [NSString stringWithFormat:@"%@", tmp];
            data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
            [outputStream write:[data bytes] maxLength:[data length]];
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"TCP Client - Error Connecting to Host");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"TCP Client - Stream Has Ended");
            [aStream close];
            [aStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            break;
        case NSStreamEventNone:
            NSLog(@"TCP Client - None event");
            break;
        case NSStreamEventHasBytesAvailable:
            NSLog(@"TCP Client - Bytes Available");
            if (aStream == inputStream)
            {
                uint8_t buffer[1024];
                NSInteger len;
                
                while ([inputStream hasBytesAvailable])
                {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0)
                    {
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        
                        if (nil != output)
                        {
                            NSLog(@"TCP Client - Server sent: %@", output);
                        }
                        
                        //Send some data (large block where the write may not actually send all we request it to send)
                        NSInteger ActualOutputBytes = [outputStream write:[outputData bytes] maxLength:[outputData length]];
                        
                        if (ActualOutputBytes >= 1024)
                        {
                            //It was all sent
                            outputData = nil;
                        }
                        else
                        {
                            //Only partially sent
                            [outputData replaceBytesInRange:NSMakeRange(0, ActualOutputBytes) withBytes:NULL length:0];
                            //Remove sent bytes from the start
                        }
                    }
                }
            }
            break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"TCP Client - Space Available");
            if (outputData != nil)
            {
                //Send rest of the packet
                NSInteger ActualOutputBytes = [outputStream write:[outputData bytes] maxLength:[outputData length]];
                
                if (ActualOutputBytes >= [outputData length])
                {
                    //It was all sent
                    outputData = nil;
                }
                else
                {
                    //Only partially sent
                    [outputData replaceBytesInRange:NSMakeRange(0, ActualOutputBytes) withBytes:NULL length:0];
                    //Remove sent bytes from the start
                }
            }
            break;
        default:
            NSLog(@"TCP Client - Unknown event");
            break;
    }
}


@end
