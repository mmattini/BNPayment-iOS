//
//  BNTokenizedCreditCard.m
//  Pods
//
//  Created by Bambora On Mobile AB on 19/01/2016.
//
//

#import "BNAuthorizedCreditCard.h"
#import "BNPaymentParams.h"

@implementation BNAuthorizedCreditCard

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"creditCardAlias" :       @"cardAlias",
             @"creditCardNumber" :      @"cardNumber",
             @"creditCardToken" :       @"recurringPaymentID",
             @"creditCardType" :        @"cardType",
             @"creditCardExpiryMonth" : @"expiryMonth",
             @"creditCardExpiryYear" :  @"expiryYear"
             };
}

- (BNPaymentParams *)paymentParamsWithId:(NSString *)identifier
                                currency:(NSString *)currency
                                  amount:(NSNumber *)amount
                                 comment:(NSString *)comment {
    
    return [BNPaymentParams paymentParamsWithId:identifier
                                       currency:currency
                                         amount:amount
                                          token:self.creditCardToken
                                        comment:comment];
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToAuthorizedCard:other];
}

- (BOOL)isEqualToAuthorizedCard:(BNAuthorizedCreditCard *)authorizedCard {
    if (!authorizedCard || ![authorizedCard isKindOfClass:[self class]]) {
        return NO;
    }
    
    return self == authorizedCard || [self.creditCardToken isEqualToString:authorizedCard.creditCardToken];
}

- (NSUInteger)hash {
    return [super hash];
}

@end
