//
//  BNTokenizedCreditCard.h
//  Pods
//
//  Created by Bambora On Mobile AB on 19/01/2016.
//
//
#import <BNBase/BNBaseModel.h>

@class BNPaymentParams;

/**
 *  `BNAuthorizedCreditCard` represents a tokenized credit card.
 */
@interface BNAuthorizedCreditCard : BNBaseModel

@property (nonatomic, strong) NSString *creditCardAlias;
@property (nonatomic, strong) NSString *creditCardNumber;
@property (nonatomic, strong) NSString *creditCardToken;
@property (nonatomic, strong) NSString *creditCardType;
@property (nonatomic, strong) NSNumber *creditCardExpiryMonth;
@property (nonatomic, strong) NSNumber *creditCardExpiryYear;

/**
 *  A convenience method for creating an instance of `BNPaymentParams`
 *
 *  @param identifier `NSString` Representing the identifier of the payment.
 *  @param currency   `NSString` Representing the ISO 4217 currency code of the payment.
 *  @param amount     `NSString` Representing the amount in cents of the payment.
 *  @param comment    `NSString` Reprenseting an optional comment for the payment.
 *
 *  @return An instance of `BNPaymentParams`
 */
- (BNPaymentParams *)paymentParamsWithId:(NSString *)identifier
                                currency:(NSString *)currency
                                  amount:(NSNumber *)amount
                                 comment:(NSString *)comment;

@end
