//
//  BNSecurityTests.m
//  BNBaseLibrary
//
//  Created by Bambora On Mobile AB on 10/03/2016.
//  Copyright © 2016 Bambora On Mobile AB. All rights reserved.
//

#import <BNBase/BNBase.h>

@import XCTest;

@interface BNSecurityTests : XCTestCase

@end

@implementation BNSecurityTests {
    BNSecurity *_security;
    NSData *_invalidSelfSignedCertData;
    NSData *_validCertData;
    NSData *_validCACertData;
    NSData *_validExpiredCertData;
    SecTrustRef _invalidSelfSignedSecTrust;
    SecTrustRef _validSecTrust;
    SecTrustRef _validExpiredSecTrust;
}

- (void)setUp {
    [super setUp];
    
    _security = [BNSecurity new];

    NSString *invalidSelfSignedCertPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"invalidSelfSignedCert" ofType:@"cer"];
    NSString *validCertPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"validSelfSignedCert" ofType:@"cer"];
    NSString *validCaCertPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"validCACert" ofType:@"cer"];
    NSString *validExpiredCertPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"validExpiredSelfSignedCert" ofType:@"cer"];
    
    XCTAssertNotNil(invalidSelfSignedCertPath, "Invalid self signed cert not nil");
    XCTAssertNotNil(validCertPath, "Valid self signed cert not nil");
    XCTAssertNotNil(validCaCertPath, "Valid  CA cert not nil");
    XCTAssertNotNil(validExpiredCertPath, "Valid but expired self signed cert not nil");
    
    _invalidSelfSignedCertData = [NSData dataWithContentsOfFile:invalidSelfSignedCertPath];
    _validCertData = [NSData dataWithContentsOfFile:validCertPath];
    _validCACertData = [NSData dataWithContentsOfFile:validCaCertPath];
    _validExpiredCertData = [NSData dataWithContentsOfFile:validExpiredCertPath];
    
    XCTAssertNotNil(_invalidSelfSignedCertData, "Invalid self signed cert data not nil");
    XCTAssertNotNil(_validCertData, "Valid self signed cert data not nil");
    XCTAssertNotNil(_validCACertData, "Valid self signed CA cert data not nil");
    XCTAssertNotNil(_validExpiredCertData, "Valid but expired self signed data not nil");
    
    // Replace pinned certs for these tests.
    NSArray *overrideCerts = @[_validCACertData];
    [_security overridePinnedCerts:overrideCerts];
    
    SecPolicyRef secPolicy = SecPolicyCreateBasicX509();
    
    SecCertificateRef invalidSelfSignedCert = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)_invalidSelfSignedCertData);
    SecCertificateRef validCert = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)_validCertData);
    SecCertificateRef validExpiredCert = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)_validExpiredCertData);
    
    SecTrustCreateWithCertificates(invalidSelfSignedCert, secPolicy, &_invalidSelfSignedSecTrust);
    SecTrustCreateWithCertificates(validCert, secPolicy, &_validSecTrust);
    SecTrustCreateWithCertificates(validExpiredCert, secPolicy, &_validExpiredSecTrust);
}

- (void)testValidCertWithCorrectDomain {
    BOOL isServerTrusted = [_security evaluateServerTrust:_validSecTrust forDomain:@"ironpoodle.zebragiraffe.net"];
    XCTAssertTrue(isServerTrusted, "Should accept a SecTrustRef signed by a pinned cert and correct domain");
}

- (void)testValidButExpiredCertWithCorrectDomain {
    BOOL isServerTrusted = [_security evaluateServerTrust:_validExpiredSecTrust forDomain:@"ironpoodle.zebragiraffe.net"];
    XCTAssertFalse(isServerTrusted, "Should not accept a SecTrustRef signed by a correct pinned cert which is expired and correct domain");
}

- (void)testValidCertWithIncorrectDomain {
    BOOL isServerTrusted = [_security evaluateServerTrust:_validSecTrust forDomain:@"ironpoodle.zebragiraffe.com"];
    XCTAssertFalse(isServerTrusted, "Should not accept a SecTrustRef signed by a pinned cert and incorrect domain");
}

- (void)testInvalidCertWithCorrectDomain {
    BOOL isServerTrusted = [_security evaluateServerTrust:_invalidSelfSignedSecTrust forDomain:@"ironpoodle.zebragiraffe.net"];
    XCTAssertFalse(isServerTrusted, "Should not accept a SecTrustRef not signed by a pinned cert and correct domain");
}

- (void)testInvalidCertWithIncorrectDomain {
    BOOL isServerTrusted = [_security evaluateServerTrust:_invalidSelfSignedSecTrust forDomain:@"ironpoodle.zebragiraffe.com"];
    XCTAssertFalse(isServerTrusted, "Should not accept a SecTrustRef not signed by a pinned cert and incorrect domain");
}

- (void)testValidCertWithNilDomain {
    BOOL isServerTrusted = [_security evaluateServerTrust:_validSecTrust forDomain:nil];
    XCTAssertFalse(isServerTrusted, "Should not accept nil value for Domain with valid cert");
}

- (void)testNilCertWithCorrectDomain {
    BOOL isServerTrusted = [_security evaluateServerTrust:nil forDomain:@"ironpoodle.zebragiraffe.net"];
    XCTAssertFalse(isServerTrusted, "Should not accept nil value for SecTrustRef and correct domain");
}

- (void)testNilCertWithNilDomain {
    BOOL isServerTrusted = [_security evaluateServerTrust:nil forDomain:nil];
    XCTAssertFalse(isServerTrusted, "Should not accept nil value for SecTrust and Domain");
}

- (void)testDefaultCertOvveride {
    NSArray *overrideCerts = @[_validCertData];
    [_security overridePinnedCerts:overrideCerts];
    
    BOOL isServerTrusted = [_security evaluateServerTrust:_validSecTrust forDomain:@"ironpoodle.zebragiraffe.net"];
    XCTAssertTrue(isServerTrusted, "Should be able to ovveride default pinned certs");
    
    overrideCerts = @[_invalidSelfSignedCertData];
    [_security overridePinnedCerts:overrideCerts];
    
    isServerTrusted = [_security evaluateServerTrust:_validSecTrust forDomain:@"ironpoodle.zebragiraffe.net"];
    XCTAssertFalse(isServerTrusted, "Should be able to ovveride default pinned certs");
    
    // Switch back
    overrideCerts = @[_validCertData];
    [_security overridePinnedCerts:overrideCerts];
}

- (void)tearDown {
    [super tearDown];
 
    _security = nil;
    CFRelease(_invalidSelfSignedSecTrust);
    CFRelease(_validSecTrust);
    CFRelease(_validExpiredSecTrust);
}

@end