//
//  BNHandlerTests.m
//  Copyright (c) 2016 Bambora ( http://bambora.com/ )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


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