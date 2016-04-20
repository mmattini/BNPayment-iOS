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

/**
 *  A method for obtaining a reference to the class singleton.
 *
 *  @return `BNCertManager` singleton instance.
 */
+ (BNCertManager *)sharedInstance;

/**
 *  A method for replacing the encryption certificates used by client side 
 *  encryption in order to safely send credit cards over the Internet.
 *
 *  @param encryptionCertificates `NSArray` containing the new encryption certificates.
 */
- (void)replaceEncryptionCertificates:(NSArray<BNEncryptionCertificate *> *)encryptionCertificates;

/**
 *  A method for retrieving the encryption certificates used for client 
 *  side encryption.
 *
 *  @return `NSArray` containing the certificates.
 */
- (NSArray<BNEncryptionCertificate *> *)getEncryptionCertificates;

@end
