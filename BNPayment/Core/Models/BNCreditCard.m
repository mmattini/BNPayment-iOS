//
//  BNCreditCard.m
//  Pods
//
//  Created by Bambora On Mobile AB on 12/01/2016.
//
//

#import "BNCreditCard.h"
#import "NSString+BNCrypto.h"

@implementation BNCreditCard

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"alias" : @"alias",
             @"cardNumber" : @"cardNumber",
             @"expMonth" : @"expMonth",
             @"expYear" : @"expYear",
             @"cvv" : @"cvv",
             };
}

- (NSDictionary *)encryptedCreditCardWithSessionKey:(NSData *)sessionKey {
    NSMutableDictionary *encyptedCreditCardDetails = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    [encyptedCreditCardDetails setObject:[self.cardNumber AES256EncryptWithKey:sessionKey] forKey:@"cardNumber"];
    [encyptedCreditCardDetails setObject:[self.expMonth AES256EncryptWithKey:sessionKey] forKey:@"expMonth"];
    [encyptedCreditCardDetails setObject:[self.expYear AES256EncryptWithKey:sessionKey] forKey:@"expYear"];
    [encyptedCreditCardDetails setObject:[self.cvv AES256EncryptWithKey:sessionKey] forKey:@"cvv"];

    return encyptedCreditCardDetails;
}

@end
