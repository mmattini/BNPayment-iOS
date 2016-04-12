//
//  BNCreditCardEndpointTests.m
//  BNPayment
//
//  Created by Bambora On Mobile AB on 10/12/2015.
//  Copyright © 2015 Bambora On Mobile AB. All rights reserved.
//

@interface BNCreditCardEndpointTests : XCTestCase

@property NSString *fileName;
@property int statusCode;

@end

@implementation BNCreditCardEndpointTests

+ (void)setUp {
    [super setUp];
    
    [OHHTTPStubs setEnabled:YES];
    
    NSError *error;
    [BNHandler setupWithApiToken:@"T000000000" baseUrl:nil debug:YES error:&error];
}

- (void)setUp {
    [super setUp];

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
    self.fileName = @"registerCreditCardSuccess.json";
    self.statusCode = 200;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Credit card endpoint test"];
    
    NSURLSessionDataTask *task = [BNCreditCardEndpoint initiateCreditCardRegistrationForm:[BNCCHostedFormParams mockObject] completion:^(NSString *url, NSError *error) {
        XCTAssertTrue([url isKindOfClass:[NSString class]], "URL is a string");
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
    self.fileName = @"registerCreditCardExtraParams.json";
    self.statusCode = 200;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Credit card endpoint test"];
    
    NSURLSessionDataTask *task = [BNCreditCardEndpoint initiateCreditCardRegistrationForm:[BNCCHostedFormParams mockObject] completion:^(NSString *url, NSError *error) {
        XCTAssertTrue([url isKindOfClass:[NSString class]], "URL is a string");
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
    self.fileName = @"registerCreditCardSuccess.json";
    self.statusCode = 400;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Credit card endpoint test"];
    
    NSURLSessionDataTask *task = [BNCreditCardEndpoint initiateCreditCardRegistrationForm:[BNCCHostedFormParams mockObject] completion:^(NSString *url, NSError *error) {
        XCTAssertNil(url, "URL is nil");
        XCTAssertNotNil(error, "Error is not nil");
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
    self.fileName = @"registerCreditCardSuccess.json";
    self.statusCode = 500;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Credit card endpoint test"];
    
    NSURLSessionDataTask *task = [BNCreditCardEndpoint initiateCreditCardRegistrationForm:[BNCCHostedFormParams mockObject] completion:^(NSString *url, NSError *error) {
        XCTAssertNil(url, "URL is nil");
        XCTAssertNotNil(error, "Error is not nil");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}

- (void)tearDown {
    [super tearDown];
    [OHHTTPStubs removeAllStubs];
}

@end