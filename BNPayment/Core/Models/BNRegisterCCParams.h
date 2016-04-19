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

- (void)addSessionKey:(NSString *)sessionKey withFingerprint:(NSString *)fingerprint;

@end
