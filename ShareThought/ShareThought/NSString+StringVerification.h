//
//  NSString+StringVerification.h
//  ShareThought
//
//  Created by UH Game and Entrepreneurship on 10/26/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringVerification)
- (BOOL)isValidEmail;
- (BOOL)containsNumber;
- (BOOL)containsUpperCaseCharacter;
- (BOOL)hasPunctuation;
@end
