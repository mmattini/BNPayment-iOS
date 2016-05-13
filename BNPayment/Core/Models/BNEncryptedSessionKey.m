//
//  BNEncryptedSessionKey.m
//  BNPayment
//
//  Created by Oskar Henriksson on 12/05/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import "BNEncryptedSessionKey.h"

@implementation BNEncryptedSessionKey

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"fingerprint" : @"fingerprint",
             @"sessionKey" : @"sessionKey"
             };
}

@end
