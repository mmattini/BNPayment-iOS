//
//  BNTransactionEndpoint.h
//  Pods
//
//  Created by Bambora On Mobile AB on 17/09/2015.
//
//

#import <Foundation/Foundation.h>

@class BNPaymentHandler;
@class BNPaymentResponse;
@class BNPaymentParams;

/**
 *  A block object to be executed when a payment authorization operation has completed.
 *  The block return a `BNPaymentResponse` representing the payment that is authorized.
 *  `BNError` representing the error recieved. error is nil is operation is successful.
 *
 *  @param paymentResponse  `BNPaymentResponse` is the response.
 *  @param error            `BNError` error.
 */

@class BNError;

typedef void (^BNPaymentRequestBlock)(BNPaymentResponse *paymentResponse, BNError *error);

/**
 `BNTransactionEndpoint` is a subclass of `BNBaseEndpoint`
 `BNTransactionEndpoint` offers conveniens methods for handling payment API calls.
 */
@interface BNPaymentEndpoint : NSObject

/**
*  A method for authorizing a payment.
*
*  @param params            `BNPaymentParams` representing the payment to be authroized.
*  @param completion        `BNPaymentRequestBlock` excecuted when the operation is completed.
*
*  @return `NSURLSessionDataTask`
*/
+ (NSURLSessionDataTask *)authorizePaymentWithParams:(BNPaymentParams *)params
                                          completion:(BNPaymentRequestBlock)completion;

@end
