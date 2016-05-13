//
//  BNCreditCardEndpoint.h
//  Pods
//
//  Created by Bambora On Mobile AB on 17/09/2015.
//
//

@class BNCCHostedFormParams;
@class BNRegisterCCParams;
@class BNAuthorizedCreditCard;

@import Foundation;

/**
 *  A block object to be executed when a credit card hosted form URL operation has completed.
 *  The block return an String containing the url to load in order to load the registration form and
 *  `NSError` representing the error recieved. error is nil is operation is successful.
 *
 *  @param url `NSString`
 *  @param error `NSError`
 */
typedef void (^BNCreditCardUrlBlock)(NSString *url, NSError *error);


/**
 *  A block object to be executed when a credit card registration operation has completed.
 *  The block return an `BNAuthorizedCard` containing the authorized credit card and
 *  `NSError` representing the error recieved. error is nil is operation is successful.
 *
 *  @param BNAuthorizedCreditCard   `BNAuthorizedCard`
 *  @param error                    `NSError`
 */
typedef void (^BNCreditCardRegistrationBlock)(BNAuthorizedCreditCard *card, NSError *error);

typedef void (^BNEncryptionCertBlock)(NSArray *encryptionCertificates, NSError *error);

/**
 `BNCreditCardEndpoint` is a subclass of `BNBaseEndpoint`
 `BNCreditCardEndpoint` offers conveniens methods for handling credit card API calls.
 */
@interface BNCreditCardEndpoint : NSObject

///------------------------------------------------
/// @name Credit card registration methods
///------------------------------------------------

/**
*  Initiate Credit card registration form URL operation.
*
*  @param formParams `BNCCHostedFormParams` params to the request.
*  @param completion `BNCreditCardUrlBlock` block to be executed when the initiate credit card registration operation is finished.
*
*  @return `NSURLSessionDataTask`
*/
+ (NSURLSessionDataTask *)initiateCreditCardRegistrationForm:(BNCCHostedFormParams *)formParams
                                                  completion:(BNCreditCardUrlBlock)completion;

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

+ (NSURLSessionDataTask *)encryptionCertificatesWithCompletion:(BNEncryptionCertBlock)completion;

@end
