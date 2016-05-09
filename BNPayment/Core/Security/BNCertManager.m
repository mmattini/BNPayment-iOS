//
//  BNCertManager.m
//  BNPayment
//
//  Created by Oskar Henriksson on 19/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import "BNCertManager.h"
#import "BNEncryptionCertificate.h"
#import "NSString+BNCrypto.h"
#import "BNCacheManager.h"

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

- (instancetype)init {
    self = [super init];
    if(self) {
        _encryptionCertificates = [self getEncryptionCertificates];
        
        if(!_encryptionCertificates) {
            _encryptionCertificates = [self getCertificatesFromBundle:[NSBundle bundleForClass:self.class]];
        }
    }
    return self;
}

- (void)replaceEncryptionCertificates:(NSArray<BNEncryptionCertificate *> *)encryptionCertificates {
    [[BNCacheManager sharedCache] saveObject:encryptionCertificates
                                    withName:EncryptionCertificatesCacheName];
    _encryptionCertificates = encryptionCertificates;
}

- (NSArray<BNEncryptionCertificate *> *)getEncryptionCertificates {
    if(!_encryptionCertificates) {
        _encryptionCertificates = (NSArray<BNEncryptionCertificate *> *)[[BNCacheManager sharedCache] getObjectWithName:EncryptionCertificatesCacheName];
        if(!_encryptionCertificates) {
        }
    }
    
    return _encryptionCertificates;
}

- (NSArray<BNEncryptionCertificate *> *)getCertificatesFromBundle:(NSBundle *)bundle {
    NSArray *rootPaths = [bundle pathsForResourcesOfType:@"cer" inDirectory:@"."];
    
    NSMutableArray *certificates = [NSMutableArray arrayWithCapacity:[rootPaths count]];
    for (NSString *path in rootPaths) {
        NSError *error;
        NSString *certString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        NSData *certificateData = [certString getCertData];

        BNEncryptionCertificate *cert = [BNEncryptionCertificate new];
        cert.base64Representation = [certificateData base64EncodedStringWithOptions:0];
        cert.fingerprint = @"123123";
        [certificates addObject:cert];
    }
    
    return certificates;
}

@end
