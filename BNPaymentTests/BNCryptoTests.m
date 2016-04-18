//
//  BPSCryptoTests.m
//  BPSPayment
//
//  Created by Oskar Henriksson on 17/03/2016.
//  Copyright © 2016 Oskar Henriksson. All rights reserved.
//

/*
#import "BPSCrypto.h"

SpecBegin(BPSCryptoSpecs)

describe(@"BPSCrypto", ^{
    
    static const UInt8 publicKeyIdentifier[] = "net.zebragiraffe.sample.publickey\0";
    static const UInt8 privateKeyIdentifier[] = "net.zebragiraffe.sample.privatekey\0";
    
    __block SecKeyRef privateKeySecTrust;
    __block SecKeyRef publicKeySecTrust;
    
    beforeAll(^{
        OSStatus status = noErr;

        NSMutableDictionary *privateKeyAttr = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *publicKeyAttr = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *keyPairAttr = [[NSMutableDictionary alloc] init];

        NSData * publicTag = [NSData dataWithBytes:publicKeyIdentifier
                                            length:strlen((const char *)publicKeyIdentifier)];
        NSData * privateTag = [NSData dataWithBytes:privateKeyIdentifier
                                             length:strlen((const char *)privateKeyIdentifier)];
        
        [keyPairAttr setObject:(__bridge id)kSecAttrKeyTypeRSA
                        forKey:(__bridge id)kSecAttrKeyType];
        [keyPairAttr setObject:[NSNumber numberWithInt:1024]
                        forKey:(__bridge id)kSecAttrKeySizeInBits];
        
        [privateKeyAttr setObject:[NSNumber numberWithBool:YES]
                           forKey:(__bridge id)kSecAttrIsPermanent];
        [privateKeyAttr setObject:privateTag
                           forKey:(__bridge id)kSecAttrApplicationTag];
        
        [publicKeyAttr setObject:[NSNumber numberWithBool:YES]
                          forKey:(__bridge id)kSecAttrIsPermanent];
        [publicKeyAttr setObject:publicTag
                          forKey:(__bridge id)kSecAttrApplicationTag];
        
        [keyPairAttr setObject:privateKeyAttr
                        forKey:(__bridge id)kSecPrivateKeyAttrs];
        [keyPairAttr setObject:publicKeyAttr
                        forKey:(__bridge id)kSecPublicKeyAttrs];
        
        status = SecKeyGeneratePair((__bridge CFDictionaryRef)keyPairAttr,
                                    &publicKeySecTrust, &privateKeySecTrust);
        
        expect(privateKeySecTrust).toNot.beNil();
        expect(publicKeySecTrust).toNot.beNil();

    });
    
    afterAll(^{
        
    });
    
});

SpecEnd
*/

@interface BNCryptoTests : XCTestCase

@end

@implementation BNCryptoTests {

}

- (void)setUp {
    [super setUp];
}


- (void)tearDown {
    [super tearDown];
}

@end