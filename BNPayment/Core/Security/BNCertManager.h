//
//  BNCertManager.h
//  BNPayment
//
//  Created by Oskar Henriksson on 19/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNEncryptionCertificate;

@interface BNCertManager : NSObject

+ (BNCertManager *)sharedInstance;

- (void)replaceEncryptionCertificates:(NSArray<BNEncryptionCertificate *> *)encryptionCertificates;

- (NSArray<BNEncryptionCertificate *> *)getEncryptionCertificates;

@end
