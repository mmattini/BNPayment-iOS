//
//  BNPayment.m
//  Pods
//
//  Created by Bambora On Mobile AB on 17/02/2016.
//
//

#import "BNPaymentParams.h"

@implementation BNPaymentParams

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"paymentIdentifier" : @"paymentIdentifier",
             @"currency" : @"currency",
             @"amount" : @"amount",
             @"token" : @"token",
             @"comment" : @"comment"
             };
}

+ (BNPaymentParams *)paymentParamsWithId:(NSString *)identifier
                                currency:(NSString *)currency
                                  amount:(NSNumber *)amount
                                   token:(NSString *)token
                                 comment:(NSString *)comment {
    BNPaymentParams *params = [BNPaymentParams new];
    
    params.paymentIdentifier = identifier;
    params.currency = currency;
    params.amount = amount;
    params.token = token;
    params.comment = comment;
    
    return params;
}

+ (BNPaymentParams *)mockObject {
    BNPaymentParams *mockObject = [BNPaymentParams new];
    mockObject.paymentIdentifier = [NSString stringWithFormat:@"%u", arc4random_uniform(INT_MAX)];
    mockObject.currency = @"SEK";
    mockObject.amount = @100;
    mockObject.token = @"58133813560350721";
    mockObject.comment = @"Mocked comment";
    
    return mockObject;
}
@end
