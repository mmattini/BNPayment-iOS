//
//  BNCreditCardEndpointTests.m
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


@interface BNCreditCardEndpointTests : XCTestCase

@property NSString *fileName;
@property int statusCode;

@end

@implementation BNCreditCardEndpointTests

+ (void)setUp {
    [super setUp];
    
    [OHHTTPStubs setEnabled:YES];
    
    NSError *error;
    [BNPaymentHandler setupWithApiToken:@"T000000000" baseUrl:nil debug:YES error:&error];
    [[BNPaymentHandler sharedInstance] registerAuthenticator:[BNAuthenticator new]];
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