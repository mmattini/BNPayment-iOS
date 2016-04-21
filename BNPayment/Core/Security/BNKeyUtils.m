//
//  BNKeyManager.m
//  BNPayment
//
//  Created by Oskar Henriksson on 18/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import "BNKeyUtils.h"
#import "NSString+BNCrypto.h"

@implementation BNKeyUtils

+ (SecKeyRef)getPublicKeyRefForCerFile:(NSString *)filename
                                bundle:(NSBundle *)bundle {
    NSString *certPath = [bundle pathForResource:filename ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:certPath];
    
    if(!certPath || !certData) {
        return nil;
    }
    
    return [BNKeyUtils getPublicKeyRefFromCertData:certData];
}

+ (SecKeyRef)getPublicKeyRefForPemFile:(NSString *)filename
                                bundle:(NSBundle *)bundle {
    NSString *certPath = [bundle pathForResource:filename ofType:@"pem"];
    
    NSError *error;
    NSString *certString = [NSString stringWithContentsOfFile:certPath encoding:NSUTF8StringEncoding error:&error];

    if(!certPath || !certString || error) {
        return nil;
    }
    
    return [BNKeyUtils getPublicKeyRefFromCertData:[certString getCertData]];
}

+ (SecKeyRef)getPublicKeyRefFromCertData:(NSData *)certData {
    SecKeyRef publicKey = nil;
    SecTrustRef certSecTrust;
    SecPolicyRef secPolicy = SecPolicyCreateBasicX509();
    
    SecCertificateRef cert = SecCertificateCreateWithData(nil, (__bridge CFDataRef)certData);
    OSStatus status = SecTrustCreateWithCertificates(cert, secPolicy, &certSecTrust);
    
    if(status != noErr) return nil;
    
    publicKey = SecTrustCopyPublicKey(certSecTrust);
    
    CFRelease(cert);
    CFRelease(secPolicy);
    
    return publicKey;
}

+ (SecKeyRef)getPrivateKeyRefForFile:(NSString *)filename
                              bundle:(NSBundle *)bundle
                        withPassword:(NSString *)password {
    SecKeyRef privateKeyRef = nil;

    NSString *certPath = [bundle pathForResource:filename ofType:@"p12"];
    NSData *certData = [NSData dataWithContentsOfFile:certPath];
    
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
    
    if(password) {
        [options setObject:password forKey:(id)kSecImportExportPassphrase];        
    }

    CFArrayRef items = CFArrayCreate(nil, 0, 0, nil);
    
    OSStatus securityError = SecPKCS12Import((CFDataRef) certData,
                                             (CFDictionaryRef)options,
                                             &items);
    
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict,
                                                                          kSecImportItemIdentity);
        
        securityError = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
        if (securityError != noErr) {
            privateKeyRef = nil;
        }
    }
    
    return privateKeyRef;
}

@end
