//
//  BNPaymentResponse.m
//  Pods
//
//  Created by Bambora On Mobile AB on 17/02/2016.
//
//

#import "BNPaymentResponse.h"

@implementation BNPaymentResponse

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"region" : @"region",
             @"merchant" : @"merchant",
             @"payment" : @"payment",
             @"state" : @"state",
             @"currency" : @"currency",
             @"amount" : @"amount",
             @"comment" : @"comment",
             @"captures" : @"captures",
             };
}

@end
