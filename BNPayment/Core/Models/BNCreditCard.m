//
//  BNCreditCard.m
//  Pods
//
//  Created by Bambora On Mobile AB on 12/01/2016.
//
//

#import "BNCreditCard.h"

@implementation BNCreditCard

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"alias" : @"alias",
             @"cardNumber" : @"card_number",
             @"expiryDate" : @"expiry_date",
             @"cvv" : @"cvv",
             };
}

@end
