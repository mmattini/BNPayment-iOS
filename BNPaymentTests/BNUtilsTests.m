//
//  BNUtilsTests.m
//  BNBaseLibrary
//
//  Created by Bambora On Mobile AB on 08/01/2016.
//  Copyright © 2016 Bambora On Mobile AB. All rights reserved.
//

#import <BNPayment/BNPayment.h>

@import XCTest;

@interface BNUtilsTests : XCTestCase

@end

@implementation BNUtilsTests

- (void)testGenerateSHA256HMAC {
    NSString *data = @"The quick brown fox jumps over the lazy dog";
    NSString *key = @"key";
    
    NSString *hmac = [BNUtils sha256HMAC:data key:key];
    NSString *correctHmac = @"f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8";
    
    XCTAssertEqualObjects(correctHmac, hmac, "Correct SHA256 HCMAC generated");
}

@end