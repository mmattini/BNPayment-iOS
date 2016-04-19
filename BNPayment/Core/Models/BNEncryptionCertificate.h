//
//  BNEncryptionCertificate.h
//  BNPayment
//
//  Created by Oskar Henriksson on 19/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import <BNBase/BNBase.h>

@interface BNEncryptionCertificate : BNBaseModel

@property (nonatomic, strong) NSString *fingerprint;
@property (nonatomic, strong) NSString *base64Representation;

- (NSString *)encryptSessionKey:(NSData *)sessionKey;

@end
