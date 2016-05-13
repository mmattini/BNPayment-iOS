//
//  BNEncryptedSessionKey.h
//  BNPayment
//
//  Created by Oskar Henriksson on 12/05/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import <BNPayment/BNPayment.h>

@interface BNEncryptedSessionKey : BNBaseModel

@property (nonatomic, strong) NSString *fingerprint;
@property (nonatomic, strong) NSString *sessionKey;

@end
