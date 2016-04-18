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

static const int KEY_LENGTH = 32;

- (void)setUp {
    [super setUp];
    
    uint8_t randomBytes[KEY_LENGTH];
    SecRandomCopyBytes(kSecRandomDefault, KEY_LENGTH, randomBytes);
    self.key = [NSData dataWithBytes:randomBytes length:sizeof(randomBytes)];
    self.stringToEncrypt = @"String to encrypt";

}

- (void)testEncryptDecryptWithAES256 {
    NSString *encryptedString = [self.stringToEncrypt AES256EncryptWithKey:self.key];
    XCTAssertNotEqualObjects(self.stringToEncrypt, encryptedString, "Encrypted string is not equal to original string");
    
    NSString *decryptedString = [encryptedString AES256DecryptWithKey:self.key];
    XCTAssertEqualObjects(self.stringToEncrypt, decryptedString, "The decrypted string is equal to the original string");
}

- (void)tearDown {
    [super tearDown];
}

@end