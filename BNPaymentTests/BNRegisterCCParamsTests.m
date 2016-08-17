//
//  BNRegisterCCParamsTests.m
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

#import <XCTest/XCTest.h>

@interface BNRegisterCCParamsTests : XCTestCase

@property NSData *key;
@property BNCreditCard *cardToEncrypt;

@end

@implementation BNRegisterCCParamsTests

static const int KEY_LENGTH = 16;

- (void)setUp {
    [super setUp];

    // NSString *validCertPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"validSelfSignedCert" ofType:@"cer"];
    // NSData *certData = [NSData dataWithContentsOfFile:validCertPath];

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


- (void)testJSONMappingDictionary {

    // Given:
    NSDictionary *correctDictionary = @{
                                        @"cardDetails" : @"encryptedCard",
                                        @"binNumber" : @"binNumber",
                                        @"encryptedSessionKeys" : @"encryptedSessionKeys"
                                        };
    
    // When:
    NSDictionary *dictionaryFromBNRegisterCCParams = [BNRegisterCCParams JSONMappingDictionary];
    
    // Then:
    XCTAssertEqualObjects(correctDictionary, dictionaryFromBNRegisterCCParams, "The manually added dictionary (correctDictionary) should equal the dictionary generated through the BNRegisterCCParams class.");
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

@end
