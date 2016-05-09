//
//  BNPaymentEndpointTests.m
//  BNPayment
//
//  Created by Bambora On Mobile AB on 10/12/2015.
//  Copyright © 2015 Bambora On Mobile AB. All rights reserved.
//

@interface BNPaymentEndpointTests : XCTestCase

@property NSString *fileName;
@property int statusCode;

@end

@implementation BNPaymentEndpointTests

+ (void)setUp {
    [super setUp];
    
    [OHHTTPStubs setEnabled:YES];
    
    NSError *error;
    [BNPaymentHandler setupWithApiToken:@"T000000000" baseUrl:nil debug:YES error:&error];
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
    self.fileName = @"authorizePaymentSuccess.json";
    self.statusCode = 200;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Credit card endpoint test"];
    BNPaymentParams *params = [BNPaymentParams mockObject];
    NSURLSessionDataTask *task = [BNPaymentEndpoint authorizePaymentWithParams:params completion:^(BNPaymentResponse *paymentResponse, NSError *error) {
        XCTAssertNil(error, "Error is nil");
        XCTAssertTrue([paymentResponse isKindOfClass:[BNPaymentResponse class]], "Payment response is kind of BNPaymentResponse");
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
    self.fileName = @"authorizePaymentSuccessExtraParams.json";
    self.statusCode = 200;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Credit card endpoint test"];
    BNPaymentParams *params = [BNPaymentParams mockObject];
    NSURLSessionDataTask *task = [BNPaymentEndpoint authorizePaymentWithParams:params completion:^(BNPaymentResponse *paymentResponse, NSError *error) {
        XCTAssertNil(error, "Error is nil");
        XCTAssertTrue([paymentResponse isKindOfClass:[BNPaymentResponse class]], "Payment response is kind of BNPaymentResponse");
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
    self.fileName = @"authorizePaymentSuccess.json";
    self.statusCode = 400;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Credit card endpoint test"];
    BNPaymentParams *params = [BNPaymentParams mockObject];
    NSURLSessionDataTask *task = [BNPaymentEndpoint authorizePaymentWithParams:params completion:^(BNPaymentResponse *paymentResponse, NSError *error) {
        XCTAssertNotNil(error, "Error is not nil");
        XCTAssertNil(paymentResponse, "Payment response is nil");
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
    self.fileName = @"authorizePaymentSuccess.json";
    self.statusCode = 500;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Credit card endpoint test"];
    BNPaymentParams *params = [BNPaymentParams mockObject];
    NSURLSessionDataTask *task = [BNPaymentEndpoint authorizePaymentWithParams:params completion:^(BNPaymentResponse *paymentResponse, NSError *error) {
        XCTAssertNotNil(error, "Error is not nil");
        XCTAssertNil(paymentResponse, "Payment response is nil");
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
    [OHHTTPStubs removeAllStubs];
    [super tearDown];
}

@end