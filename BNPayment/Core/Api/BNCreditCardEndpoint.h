//
//  BNCreditCardEndpoint.h
//  Pods
//
//  Created by Bambora On Mobile AB on 17/09/2015.
//
//
#import "BNPaymentHandler.h"

@class BNError;
@class BNCCHostedFormParams;

/**
 *  A block object to be executed when a credit card registration operation has completed.
 *  The block return an String containing the url to load in order to register a credit card
 *  `BNError` representing the error recieved. error is nil is operation is successful.
 *
 *  @param url `NSString`
 *  @param error `BNError`
 */
typedef void (^BNCreditCardUrlBlock)(NSString *url, BNError *error);

/**
 `BNCreditCardEndpoint` is a subclass of `BNBaseEndpoint`
 `BNCreditCardEndpoint` offers conveniens methods for handling credit card API calls.
 */
@interface BNCreditCardEndpoint : NSObject

///------------------------------------------------
/// @name Credit card registration methods
///------------------------------------------------

/**
*  Initiate Credit card registration.
*
*  @param formParams `BNCCHostedFormParams` params to the request.
*  @param block `BNCreditCardUrlBlock` block to be executed when the initiate credit card registration operation is finished.
*
*  @return `NSURLSessionDataTask`
*/
+ (NSURLSessionDataTask *)initiateCreditCardRegistrationForm:(BNCCHostedFormParams *)formParams
                                                       block:(BNCreditCardUrlBlock)block;

@end
