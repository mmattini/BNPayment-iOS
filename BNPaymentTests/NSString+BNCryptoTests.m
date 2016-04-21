//
//  BPSNSString+BPSCryptoTests.m
//  BPSPayment
//
//  Created by Oskar Henriksson on 17/03/2016.
//  Copyright © 2016 Oskar Henriksson. All rights reserved.
//

@interface NSStringBNCryptoTests : XCTestCase

@property NSData *key;
@property NSString *stringToEncrypt;

@end

@implementation NSStringBNCryptoTests

static const int KEY_LENGTH = 16;

- (void)setUp {
    [super setUp];
    
    uint8_t randomBytes[KEY_LENGTH];
    SecRandomCopyBytes(kSecRandomDefault, KEY_LENGTH, randomBytes);
    self.key = [NSData dataWithBytes:randomBytes length:sizeof(randomBytes)];
    NSString *keyString = [self.key base64EncodedStringWithOptions:0];
    self.stringToEncrypt = @"String to encrypt";

}

- (void)testEncryptDecryptWithAES128 {
    NSString *encryptedString = [self.stringToEncrypt AES128EncryptWithKey:self.key];
    XCTAssertNotEqualObjects(self.stringToEncrypt, encryptedString, "Encrypted string is not equal to original string");
    
    NSString *decryptedString = [encryptedString AES128DecryptWithKey:self.key];
    XCTAssertEqualObjects(self.stringToEncrypt, decryptedString, "The decrypted string is equal to the original string");
}

- (void)tearDown {
    [super tearDown];
}

@end