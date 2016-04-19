//
//  BNKeyManagerTests.m
//  BNPayment
//
//  Created by Oskar Henriksson on 18/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BNKeyManagerTests : XCTestCase

@end

@implementation BNKeyManagerTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testGetPublicKey {
    SecKeyRef publicKey = [BNKeyUtils getPublicKeyRefForCerFile:@"iosTestCert"
                                                           bundle:[NSBundle bundleForClass:self.class]];
    XCTAssertTrue(publicKey != nil, "Public key is not nil");
}


- (void)testGetPublicKeyFromPem {
    SecKeyRef publicKey = [BNKeyUtils getPublicKeyRefForPemFile:@"iosTestCert"
                                                           bundle:[NSBundle bundleForClass:self.class]];
    XCTAssertTrue(publicKey != nil, "Public key is not nil");
}

- (void)testGetPrivateKey {
    SecKeyRef privateKey = [BNKeyUtils getPrivateKeyRefForFile:@"iOSTestPrivKey"
                                                          bundle:[NSBundle bundleForClass:self.class]
                                                    withPassword:@"1234"];
    XCTAssertTrue(privateKey != nil, "Private key is not nil");
}

@end
