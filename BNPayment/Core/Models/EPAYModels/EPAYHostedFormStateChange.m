//
//  EPAYHostedFormStateChange.m
//  Pods
//
//  Created by Bambora On Mobile AB on 22/02/2016.
//
//

#import "EPAYHostedFormStateChange.h"
#import "BNAuthorizedCreditCard.h"
#import "EPAYMetaResponse.h"
#import "EPAYAction.h"

@implementation EPAYHostedFormStateChange

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"meta": @"meta",
             @"truncatedCardNumber": @"truncatedcardnumber",
             @"expiryMonth": @"expmonth",
             @"expiryYear": @"expyear",
             @"paymentType": @"paymenttype",
             @"subscriptionId": @"subscriptionid"
             };
}

- (BNAuthorizedCreditCard *)generateAuthorizedCard {
    BNAuthorizedCreditCard *authorizedCreditCard = [BNAuthorizedCreditCard new];
    authorizedCreditCard.creditCardNumber = self.truncatedCardNumber;
    authorizedCreditCard.creditCardToken = self.subscriptionId;
    authorizedCreditCard.creditCardType = self.paymentType;
    authorizedCreditCard.creditCardExpiryMonth = self.expiryMonth;
    authorizedCreditCard.creditCardExpiryYear = self.expiryYear;
    
    return authorizedCreditCard;
}

- (NSInteger)status {
    if (self.meta && self.meta.action) {
        return [self.meta.action.code integerValue];
    }
    
    return EPAYUnknown;
}

@end
