//
//  BNHandlerTests.m
//  BNBaseLibrary
//
//  Created by Bambora On Mobile AB on 11/01/2016.
//  Copyright © 2016 Bambora On Mobile AB. All rights reserved.
//

#import <BNPayment/BNPayment.h>

@import XCTest;

@interface BNHandlerTests : XCTestCase

@property BNPaymentHandler *handler;

@end

@implementation BNHandlerTests

- (void)setUp {
    [super setUp];
    self.handler = [BNPaymentHandler sharedInstance];
}

- (void)testHandlerSetup {
    NSString *apiToken = @"api-token";
    NSString *baseUrl = @"https://zebragiraffe.net/";
    BOOL debug = YES;
    NSError *error = nil;
    
    [BNPaymentHandler setupWithApiToken:apiToken
                                baseUrl:baseUrl
                                  debug:debug
                                  error:&error];
    
    XCTAssertNotNil(_handler, "Handler is not nil");
    XCTAssertNil(error, "Error is nil");
    
    XCTAssertEqualObjects([self.handler getApiToken], apiToken, "Api token correct");
    XCTAssertEqualObjects([self.handler getBaseUrl], baseUrl, "Base URL correct");
    XCTAssertEqual([self.handler debugMode], debug, "Debug mode correct");
    XCTAssertNotNil([self.handler getHttpClient], "Handler is not nil");
    XCTAssertTrue([[self.handler getHttpClient] isKindOfClass:[BNHTTPClient class]], "HTTP client is correct class");
}

- (void)testAuthenticatorRegistration {
    BNAuthenticator *authenticator = [BNAuthenticator new];
    authenticator.sharedSecret = @"sharedsecret";
    authenticator.uuid = @"uuid";
    
    [self.handler registerAuthenticator:authenticator];
    
    XCTAssertTrue([self.handler isRegistered], "Authenticator is registered");
}

- (void)tearDown {
    [super tearDown];
    self.handler = nil;
}

@end