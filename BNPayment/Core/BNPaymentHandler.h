//
//  BNPaymentHandler.h
//  Pods
//
//  Created by Bambora On Mobile AB on 13/11/2015.
//
//

#import "BNEnums.h"
#import "BNCreditCardEndpoint.h"

@import Foundation;

@class BNAuthorizedCreditCard;
@class BNCCHostedFormParams;
@class BNAuthorizedCreditCard;
@class BNRegisterCCParams;
@class BNPaymentParams;

/**
 *  A block object to be executed when a payment operation has completed.
 *  The block return an enum representing the result of the Payment operation.
 *
 *  @param result `BNPaymentResult`.
 */
typedef void (^BNPaymentBlock) (BNPaymentResult result, NSError *error);

/**
 *  A block object to be executed when a credit card registration operation has completed.
 *  The block return an String containing the url to load in order to register a credit card
 *  `NSError` representing the error recieved. error is nil is operation is successful.
 *
 *  @param url `NSString`.
 *  @param error `NSError`.
 */
typedef void (^BNCreditCardRegistrationUrlBlock)(NSString *url, NSError *error);

@interface BNPaymentHandler : NSObject

/** 
 *  Return `BNPaymentHandler` shared instance creating it if necessary.
 *
 *  @return The shared `BNPaymentHandler` instance.
 */
+ (BNPaymentHandler *)sharedInstance;

/**
 *  Initiate Credit card registration.
 *
 *  @param block `BNCreditCardUrlBlock` block to be executed when the initiate credit card registration operation is finished.
 */

/**
 *  Initiate Credit card registration.
 *
 *  @param params `BNCCHostedFormParams` request params.
 *  @param block `BNCreditCardUrlBlock` block to be executed when the initiate credit card registration operation is finished.
 *
 *  @return `NSURLSessionDataTask`
 */
- (NSURLSessionDataTask *)initiateCreditCardRegistrationWithParams:(BNCCHostedFormParams *)params
                                                        completion:(BNCreditCardRegistrationUrlBlock) block;

/**
 *  Register a credit card in order to retrieve an authroized card used for payments.
 *
 *  @param params     `BNRegisterCCParams`
 *  @param completion `BNCreditCardRegistrationBlock`
 *
 *  @return `NSURLSessionDataTask`
 */
+ (NSURLSessionDataTask *)registerCreditCard:(BNRegisterCCParams *)params
                                  completion:(BNCreditCardRegistrationBlock)completion;

/**
 *  Make Payment
 *
 *  @param paymentParams `BNPaymentParams` params to the request.
 *  @param identifier    `NSString` prepresenting the payment identidier.
 *  @param result The block to be executed when Payment operation is finished.
 *
 *  @return `NSURLSessionDataTask`
 */
- (NSURLSessionDataTask *)makePaymentWithParams:(BNPaymentParams *)paymentParams
                                         result:(BNPaymentBlock) result;

/**
 *  A method for retrieveing an array of authorized cards previously saved.
 *
 *  @return An Array of authorized credit cards.
 */
- (NSArray <BNAuthorizedCreditCard *>*)authorizedCards;

/**
 *  A method to saving a authorized credit card model and persist it to disk.
 *
 *  @param tokenizedCreditCard The authorized card to save.
 */
- (void)saveAuthorizedCreditCard:(BNAuthorizedCreditCard *)authorizedCreditCard;

/**
 *  A method for removing a saved authorized card from disk.
 *
 *  @param tokenizedCreditCard The authorized card to remove.
 */
- (void)removeAuthorizedCreditCard:(BNAuthorizedCreditCard *)authorizedCreditCard;

@end
