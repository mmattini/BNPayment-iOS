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

- (BNCreditCard *)encryptedCreditCardWithSessionKey:(NSData *)sessionKey {
    BNCreditCard *encryptedCreditCard = [BNCreditCard new];
    
    encryptedCreditCard.alias = self.alias;
    encryptedCreditCard.cardNumber = [self.cardNumber AES256EncryptWithKey:sessionKey];
    encryptedCreditCard.expMonth = [self.expMonth AES256EncryptWithKey:sessionKey];
    encryptedCreditCard.expYear = [self.expYear AES256EncryptWithKey:sessionKey];
    encryptedCreditCard.cvv = [self.cvv AES256EncryptWithKey:sessionKey];
    
    return encryptedCreditCard;
}

@end
