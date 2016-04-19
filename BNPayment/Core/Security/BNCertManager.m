//
//  BNCertManager.m
//  BNPayment
//
//  Created by Oskar Henriksson on 19/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import "BNCertManager.h"
#import "BNEncryptionCertificate.h"
#import <BNBase/BNCacheManager.h>

NSString *const EncryptionCertificatesCacheName = @"EncryptionCertificatesCacheName";

@implementation BNCertManager {
    NSArray *_encryptionCertificates;
}

+ (BNCertManager *)sharedInstance {
    static BNCertManager *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[BNCertManager alloc] init];
    });
    
    return _sharedInstance;
}

- (void)replaceEncryptionCertificates:(NSArray<BNEncryptionCertificate *> *)encryptionCertificates {
    [[BNCacheManager sharedCache] saveObject:encryptionCertificates
                                    withName:EncryptionCertificatesCacheName];
    _encryptionCertificates = encryptionCertificates;
}

- (NSArray<BNEncryptionCertificate *> *)getEncryptionCertificates {
    if(!_encryptionCertificates) {
        _encryptionCertificates = (NSArray<BNEncryptionCertificate *> *)[[BNCacheManager sharedCache] getObjectWithName:EncryptionCertificatesCacheName];
    }
    
    return _encryptionCertificates;
}

@end
