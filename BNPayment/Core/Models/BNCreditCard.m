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
             @"expMonth" : @"expiryMonth",
             @"expYear" : @"expiryYear",
             @"cvv" : @"cvcCode",
             };
}

- (BNCreditCard *)encryptedCreditCardWithSessionKey:(NSData *)sessionKey {
    BNCreditCard *encryptedCreditCard = [BNCreditCard new];
    
    encryptedCreditCard.alias = self.alias;
    encryptedCreditCard.cardNumber = [self.cardNumber AES128EncryptWithKey:sessionKey];
    encryptedCreditCard.expMonth = [self.expMonth AES128EncryptWithKey:sessionKey];
    encryptedCreditCard.expYear = [self.expYear AES128EncryptWithKey:sessionKey];
    encryptedCreditCard.cvv = [self.cvv AES128EncryptWithKey:sessionKey];
    
    return encryptedCreditCard;
}

@end
