//
//  BPSNSString+BPSCryptoTests.m
//  BPSPayment
//
//  Created by Oskar Henriksson on 17/03/2016.
//  Copyright © 2016 Oskar Henriksson. All rights reserved.
//

/*
#import "NSString+BPSCrypto.h"

SpecBegin(BPSNSStringCryptoSpecs)

describe(@"NSString crypto", ^{
    
    __block NSData *key;
    __block NSString *stringToEncrypt;
    
    beforeAll(^{
        int keyLength = 32;
        
        uint8_t randomBytes[keyLength];
        SecRandomCopyBytes(kSecRandomDefault, keyLength, randomBytes);
        key = [NSData dataWithBytes:randomBytes length:sizeof(randomBytes)];
        expect(key).toNot.beNil();
        
        stringToEncrypt = @"String to encrypt";
    });
    
    it(@"should encrypt and decrypt with AES-256", ^{
        NSString *encryptedString = [stringToEncrypt AES256EncryptWithKey:key];
        
        expect(encryptedString).toNot.equal(stringToEncrypt);

        NSString *decryptedString = [encryptedString AES256DecryptWithKey:key];
        
        expect(decryptedString).to.equal(stringToEncrypt);
    });
    
    afterAll(^{
        
    });
    
});

SpecEnd
*/