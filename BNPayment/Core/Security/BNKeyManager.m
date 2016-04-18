//
//  BNKeyManager.m
//  BNPayment
//
//  Created by Oskar Henriksson on 18/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import "BNKeyManager.h"

@implementation BNKeyManager

+ (SecKeyRef)getPublicKeyRefForFile:(NSString *)filename
                             bundle:(NSBundle *)bundle {
    SecKeyRef publicKey = nil;
    SecTrustRef certSecTrust;
    SecPolicyRef secPolicy = SecPolicyCreateBasicX509();

    NSString *certPath = [bundle pathForResource:filename ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:certPath];
    
    if(!certPath || !certData) {
        CFRelease(secPolicy);
        return nil;
    }
    
    SecCertificateRef cert = SecCertificateCreateWithData(nil, (__bridge CFDataRef)certData);
    SecTrustCreateWithCertificates(cert, secPolicy, &certSecTrust);

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
                                             (CFDictionaryRef)options, &items);
    
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp =
        (SecIdentityRef)CFDictionaryGetValue(identityDict,
                                             kSecImportItemIdentity);
        
        securityError = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
        if (securityError != noErr) {
            privateKeyRef = nil;
        }
    }
    
    return privateKeyRef;
}

@end
