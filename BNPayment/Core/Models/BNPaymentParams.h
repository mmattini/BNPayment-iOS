//
//  BNPayment.h
//  Pods
//
//  Created by Bambora On Mobile AB on 17/02/2016.
//
//

#import <BNBase/BNBaseModel.h>

@interface BNPaymentParams : BNBaseModel

@property (nonatomic, strong) NSString *paymentIdentifier;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *comment; // Optional

+ (BNPaymentParams *)paymentParamsWithId:(NSString *)identifier
                                currency:(NSString *)currency
                                  amount:(NSNumber *)amount
                                   token:(NSString *)token
                                 comment:(NSString *)comment;

+ (BNPaymentParams *)mockObject;

@end
