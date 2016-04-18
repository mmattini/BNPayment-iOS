//
//  BPSCryptoTests.m
//  BPSPayment
//
//  Created by Oskar Henriksson on 17/03/2016.
//  Copyright © 2016 Oskar Henriksson. All rights reserved.
//

@interface BNCryptoTests : XCTestCase

@end

@implementation BNCryptoTests {
    SecKeyRef publicKey;
    SecKeyRef privateKey;
}

- (void)setUp {
    [super setUp];
    publicKey = [BNKeyManager getPublicKeyRefForFile:@"iosTestCert"
                                              bundle:[NSBundle bundleForClass:self.class]];
    privateKey = [BNKeyManager getPrivateKeyRefForFile:@"iOSTestPrivKey"
                                                bundle:[NSBundle bundleForClass:self.class]
                                          withPassword:@"1234"];
}

- (void)testRSAEncryptionDecryption {
    NSString *stringToEncrypt = @"String to encrypt/decrypt";
    
    NSData *encryptedData = [BNCrypto RSAEncryptWithData:[stringToEncrypt dataUsingEncoding:NSUTF8StringEncoding] key:publicKey];
    XCTAssertNotNil(encryptedData, "Encrypted data is not nil");
    
    NSData *decryptedData = [BNCrypto RSADecryptWithData:encryptedData key:privateKey];
    NSString *decryptedString = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    
    XCTAssertNotNil(decryptedString);
    XCTAssertEqualObjects(stringToEncrypt, decryptedString, "Inital string and decrypted string is equal");
}

- (void)tearDown {
    [super tearDown];
    CFRelease(publicKey);
    CFRelease(privateKey);
}

@end