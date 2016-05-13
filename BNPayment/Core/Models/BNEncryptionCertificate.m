//
//  BNEncryptionCertificate.m
//  BNPayment
//
//  Created by Oskar Henriksson on 19/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import "BNEncryptionCertificate.h"
#import "BNCrypto.h"
#import "BNKeyUtils.h"
#import "NSString+BNCrypto.h"

@implementation BNEncryptionCertificate

- (NSString *)encryptSessionKey:(NSData *)sessionKey {
    NSData *encryptedSessionKey = [BNCrypto RSAEncryptData:sessionKey key:[self getKeyRef]];
    return [encryptedSessionKey base64EncodedStringWithOptions:0];
}

- (SecKeyRef)getKeyRef {
    NSData *certData = [self.base64Representation getCertData];
    
    if(certData) {
        return [BNKeyUtils getPublicKeyRefFromCertData:certData];
    }
    
    return nil;
}

@end
