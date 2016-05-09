//
//  BNDateUtilsTest.m
//  BNBaseLibrary
//
//  Created by Bambora On Mobile AB on 11/01/2016.
//  Copyright © 2016 Bambora On Mobile AB. All rights reserved.
//

#import <BNPayment/BNPayment.h>

@import XCTest;

@interface BNDateUtilsTests : XCTestCase

@end

@implementation BNDateUtilsTests

- (void)testGenerateHTTPDateString {
    NSString *correctDateString = @"Mon, 11 Jan 2016 12:25:06 GMT";
    NSDate *dateToTest = [NSDate dateWithTimeIntervalSince1970:1452515106];
    NSString *dateStringToTest = [NSDate getDateHeaderFormattedStringForDate:dateToTest];
    XCTAssertEqualObjects(correctDateString, dateStringToTest, "Correct HTTP Date string generated");
}

@end