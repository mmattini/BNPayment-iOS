//
//  BNRegisterCCParamsTests.m
//  BNPayment
//
//  Created by Oskar Henriksson on 30/05/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <BNPayment/BNPayment.h>

@interface BNRegisterCCParamsTests : XCTestCase

@property NSData *key;
@property BNCreditCard *cardToEncrypt;

@end

@implementation BNRegisterCCParamsTests

static const int KEY_LENGTH = 16;

- (void)setUp {
    [super setUp];

    NSString *validCertPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"validSelfSignedCert" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:validCertPath];

    /*
    BNEncryptionCertificate *cert = [BNEncryptionCertificate new];
    cert.base64Representation = [certData base64EncodedStringWithOptions:0];
    cert.fingerprint = []
    
    [[BNCertManager sharedInstance] replaceEncryptionCertificates:@[cert]];

     */
    uint8_t key[KEY_LENGTH] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
    self.key = [NSData dataWithBytes:key length:sizeof(key)];
    self.cardToEncrypt = [BNCreditCard new];
    self.cardToEncrypt.cardNumber = @"4002620000000005";
    self.cardToEncrypt.expMonth = @"10";
    self.cardToEncrypt.expYear = @"20";
    self.cardToEncrypt.cvv = @"000";
}

- (void)testParamsSetup {
    BNRegisterCCParams *params = [[BNRegisterCCParams alloc] initWithCreditCard:self.cardToEncrypt];
    
    XCTAssertNotNil(params, "CC registration params is not nil");

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

@end
