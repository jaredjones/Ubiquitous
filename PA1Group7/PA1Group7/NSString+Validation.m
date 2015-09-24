//
//  NSString+Validation.m
//  PA1Group7
//
//  Created by Jared Jones on 9/24/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)isValidYear{
    NSUInteger year = [self integerValue];
    if (year < 1886 || year > 2016)
        return NO;
    return YES;
}

- (BOOL)isValidVINNumber{
    NSString *tmp = [self copy];
    tmp = [tmp uppercaseString];
    
    if ( [tmp length] != 17 )
        return NO;
    
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHJKLMNPRSTUVWXYZ1234567890"];
    s = [s invertedSet];
    NSRange r = [tmp rangeOfCharacterFromSet:s];
    if (r.location != NSNotFound) {
        return NO;
    }
    return YES;
}

@end
