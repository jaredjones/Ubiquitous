//
//  NSString+StringVerification.h
//  Exercise3Group7
//
//  Created by Jared Jones on 9/17/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringVerification)

- (BOOL)containsUpperCaseCharacter : (NSString*) passedString;
- (BOOL)containsNumber : (NSString*) passedString;
- (BOOL)isValidEmail : (NSString*) passedString;
- (BOOL)hasPunctuation : (NSString*) passedString;


@end
