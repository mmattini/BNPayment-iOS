//
//  BNCertificateEndpoint.h
//  BNPayment
//
//  Created by Oskar Henriksson on 19/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNEncryptionCertificate;

typedef void (^BNEncryptionCertsRequestBlock)(NSArray<BNEncryptionCertificate *> *encryptionCerts, NSError *error);

@interface BNCertificateEndpoint : NSObject

+ (NSURLSessionDataTask *)requestEncryptionCertificatesWithCompletion:(BNEncryptionCertsRequestBlock) completion;

@end
