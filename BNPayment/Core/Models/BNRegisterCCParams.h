//
//  BNRegisterCCParams.h
//  BNPayment
//
//  Created by Oskar Henriksson on 19/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import <BNBase/BNBase.h>

@class BNCreditCard;

@interface BNRegisterCCParams : BNBaseModel

@property (nonatomic, strong) BNCreditCard *cardDetails;

- (void)addEncryptedSessionKey:(NSString *)sessionKey fingerprint:(NSString *)fingerprint;

@end
