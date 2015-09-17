//
//  Exercise3Group7Tests.m
//  Exercise3Group7Tests
//
//  Created by Jared Jones on 9/17/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+StringVerification.h"

@interface Exercise3Group7Tests : XCTestCase

@end

@implementation Exercise3Group7Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertTrue(true);
}

- (void)testStringHasAnUpperCaseLetter {
    NSString* testString = @"hEllo";
    XCTAssertTrue([testString containsUpperCaseCharacter]);
}

- (void)testStringDoesNotHaveAnUpperCaseLetter {
    NSString* testString = @"hello";
    XCTAssertFalse([testString containsUpperCaseCharacter]);
}

- (void)testStringHasANumber {
    NSString* testString = @"hEl3lo";
    XCTAssertTrue([testString containsNumber]);
}

- (void)testPassedStringIsAnEmail {
    NSString* passedString = @"faysal@email.com";
    XCTAssertTrue([passedString isValidEmail]);
}
- (void)testPassedStringIsNotAnEmail {
    NSString* passedString = @"faysal";
    XCTAssertFalse([passedString isValidEmail]);
}

- (void)testPassedStringHasPunctuation {
    NSString* passedString = @"faysal@email.com";
    XCTAssertTrue([passedString hasPunctuation]);
}

- (void)testPassedStringHasNoPunctuation {
    NSString* passedString = @"faysal";
    XCTAssertFalse([passedString hasPunctuation]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
