//
//  BNRegisterCCParams.m
//  BNPayment
//
//  Created by Oskar Henriksson on 19/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import "BNRegisterCCParams.h"
#import "BNCreditCard.h"
#import "BNCrypto.h"
#import "BNCertManager.h"
#import "BNEncryptionCertificate.h"
#import "BNEncryptedSessionKey.h"

@interface BNRegisterCCParams ()

@property (nonatomic, strong) BNCreditCard *cardDetails;
@property (nonatomic, strong) NSArray<BNEncryptedSessionKey *> *encryptedSessionKeys;

@end

@implementation BNRegisterCCParams

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"cardDetails" : @"encryptedCard",
             @"encryptedSessionKeys" : @"encryptedSessionKeys"
             };
}

- (instancetype)initWithCreditCard:(BNCreditCard *)creditCard {
    self = [super init];
    if(self) {
        self.cardDetails = creditCard;
        [self generateParams];
    }
    return self;
}

- (void)generateParams {
    NSData *sessionKey = [BNCrypto generateRandomKey:16];
    NSLog(@"SessionKey: %@", sessionKey);
    self.cardDetails = [self.cardDetails encryptedCreditCardWithSessionKey:sessionKey];
    
    NSArray *encryptionCertificates = [[BNCertManager sharedInstance] getEncryptionCertificates];
    NSMutableArray *encryptedSessionKeys = [NSMutableArray new];
    
    for(BNEncryptionCertificate *cert in encryptionCertificates) {
        if([cert isKindOfClass:[BNEncryptionCertificate class]] && cert.base64Representation) {
            BNEncryptedSessionKey *encryptedSessionKey = [BNEncryptedSessionKey new];
            encryptedSessionKey.sessionKey = [cert encryptSessionKey:sessionKey];
            encryptedSessionKey.fingerprint = cert.fingerprint;
            [encryptedSessionKeys addObject:encryptedSessionKey];
        }
    }
    
    self.encryptedSessionKeys = encryptedSessionKeys;
}

/*
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
 

- (void)addEncryptedSessionKey:(NSString *)sessionKey fingerprint:(NSString *)fingerprint {
    if(!sessionKeys) {
        sessionKeys = [NSMutableDictionary new];
    }

    [sessionKeys setObject:sessionKey forKey:fingerprint];
}
 */

@end
