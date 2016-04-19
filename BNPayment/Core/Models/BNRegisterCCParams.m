//
//  BNRegisterCCParams.m
//  BNPayment
//
//  Created by Oskar Henriksson on 19/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import "BNRegisterCCParams.h"
#import "BNCreditCard.h"

@implementation BNRegisterCCParams {
    NSMutableDictionary *sessionKeys;
}

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"cardDetails" : @"cardDetails"
             };
}

- (NSDictionary *)JSONDictionary {
    NSMutableDictionary *JSONDict = [NSMutableDictionary new];
    [JSONDict setObject:[self.cardDetails JSONDictionary] forKey:@"cardDetails"];
    
    [sessionKeys enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,
                                                     id  _Nonnull obj,
                                                     BOOL * _Nonnull stop) {
        [JSONDict setObject:obj forKey:key];
    }];
    
    return JSONDict;
}

- (void)addSessionKey:(NSString *)sessionKey withFingerprint:(NSString *)fingerprint {
    if(!sessionKeys) {
        sessionKeys = [NSMutableDictionary new];
    }
    
    [sessionKeys setObject:sessionKey forKey:fingerprint];
}

@end
