//
//  NSString+StringVerification.m
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/26/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "NSString+StringVerification.h"

@implementation NSString (StringVerification)

- (BOOL)containsNumber {
    BOOL isNumeric = NO;
    for(int i = 0; i<[self length]; i++) {
        
        if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[self characterAtIndex:i]]) {
            isNumeric = YES;
        }
    }
    return isNumeric;
}

- (BOOL)containsUpperCaseCharacter{
    BOOL isUpper = NO;
    for(int i = 0; i<[self length]; i++) {
        
        if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[self characterAtIndex:i]]) {
            isUpper = YES;
        }
    }
    return isUpper;
}

-(BOOL) hasPunctuation {
    NSRange range = [self rangeOfCharacterFromSet:[NSCharacterSet
                                                   punctuationCharacterSet]];
    return range.location != NSNotFound;
}
- (BOOL)isValidEmail{
    NSString *expression = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[AZa-z]{2,4}$";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    if (match) { return true;
    } else
        return false;
}

@end
