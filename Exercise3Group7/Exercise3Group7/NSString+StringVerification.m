//
//  NSString+StringVerification.m
//  Exercise3Group7
//
//  Created by Jared Jones on 9/17/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "NSString+StringVerification.h"

@implementation NSString (StringVerification)

- (BOOL)containsNumber {
    return false;
}

- (BOOL)containsUpperCaseCharacter {
    return false;
}

-(BOOL) hasPunctuation {
    NSRange range = [self rangeOfCharacterFromSet:[NSCharacterSet
                                                   punctuationCharacterSet]];
    return range.location != NSNotFound;
}
- (BOOL)isValidEmail {
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
