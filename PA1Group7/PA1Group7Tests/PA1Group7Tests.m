//
//  PA1Group7Tests.m
//  PA1Group7Tests
//
//  Created by Jared Jones on 9/24/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Validation.h"

@interface PA1Group7Tests : XCTestCase

@end

@implementation PA1Group7Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValidYearPositive {
    NSNumber *testNumber = @2012;
    NSString *numConverted = [testNumber stringValue];
    BOOL b = [numConverted isValidYear];
    
    XCTAssertTrue(b);
}

- (void)testValidYearNegative {
    NSNumber *testNumber = @2018;
    NSString *numConverted = [testNumber stringValue];
    BOOL b = [numConverted isValidYear];
    
    XCTAssertFalse(b);
}

- (void)testValidVinNegative{
    NSString *testVin = @"8675309";
    BOOL b = [testVin isValidVINNumber];
    
    XCTAssertFalse(b);
}

- (void)testValidVinPositive{
    NSString *testVin = @"8675309AAAAAAAAZZ";
    BOOL b = [testVin isValidVINNumber];
    
    XCTAssertTrue(b);
}

@end
