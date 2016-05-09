//
//  BNRegistrationEndpointTests.m
//  BNBaseLibrary
//
//  Created by Bambora On Mobile AB on 11/01/2016.
//  Copyright © 2016 Bambora On Mobile AB. All rights reserved.
//

#import "BNBase.h"
#import "OHHTTPStubs.h"
#import "OHPathHelpers.h"

@import XCTest;
@import UIKit;

@interface BNRegistrationEndpointTests : XCTestCase

@property NSString *fileName;
@property int statusCode;

@end

@implementation BNRegistrationEndpointTests

- (void)setUp {
    [super setUp];
    
    [OHHTTPStubs setEnabled:YES];
    
    NSError *error;
    [BNHandler setupWithApiToken:@"T000000000" baseUrl:nil debug:YES error:&error];
    
    XCTAssertNil(error, "Error is nil after setup");
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString *filePath = OHPathForFile(self.fileName, self.class);
        OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithFileAtPath:filePath
                                                                         statusCode:self.statusCode
                                                                            headers:@{@"Content-Type":@"application/json"}];
        return response;
    }];
}

- (void)testSuccessfulResponse {
    self.fileName = @"registerResponseSuccess.json";
    self.statusCode = 200;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Register user"];

    NSURLSessionDataTask *task =[BNRegistrationEndpoint registerWithUser:nil completion:^(BNAuthenticator *authenticator,
                                                                                          NSError *error) {
        XCTAssertNotNil(authenticator, "Authenticator not nil");
        XCTAssertNil(error, "Error is nil");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}

- (void)testSuccessfulResponseExtraParams {
    self.fileName = @"registerResponseSuccessExtraParams.json";
    self.statusCode = 200;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Register user"];
    
    NSURLSessionDataTask *task =[BNRegistrationEndpoint registerWithUser:nil completion:^(BNAuthenticator *authenticator,
                                                                                          NSError *error) {
        XCTAssertNotNil(authenticator, "Authenticator not nil");
        XCTAssertNil(error, "Error is nil");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}

- (void)test400Response {
    self.fileName = @"registerResponseSuccess.json";
    self.statusCode = 400;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Register user"];
    
    NSURLSessionDataTask *task =[BNRegistrationEndpoint registerWithUser:nil completion:^(BNAuthenticator *authenticator,
                                                                                          NSError *error) {
        XCTAssertNil(authenticator, "Authenticator nil");
        XCTAssertNotNil(error, "Error not nil");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}

- (void)test500Response {
    self.fileName = @"registerResponseSuccess.json";
    self.statusCode = 500;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Register user"];
    
    NSURLSessionDataTask *task =[BNRegistrationEndpoint registerWithUser:nil completion:^(BNAuthenticator *authenticator,
                                                                                          NSError *error) {
        XCTAssertNil(authenticator, "Authenticator nil");
        XCTAssertNotNil(error, "Error not nil");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}

@end
