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

@implementation BNEncryptionCertificate

- (NSString *)encryptSessionKey:(NSData *)sessionKey {
    NSData *encryptedSessionKey = [BNCrypto RSAEncryptData:sessionKey key:[self getKeyRef]];
    return [encryptedSessionKey base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (SecKeyRef)getKeyRef {
    NSData *certData = [[NSData alloc] initWithBase64EncodedString:self.base64Representation options:0];
    
    if(certData) {
        return [BNKeyUtils getKeyRefFromCertData:certData];
    }
    
    return nil;
}

@end
