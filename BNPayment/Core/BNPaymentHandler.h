//
//  BNPaymentHandler.h
//  Pods
//
//  Created by Bambora On Mobile AB on 13/11/2015.
//
//

#import "BNEnums.h"

@import Foundation;

@class BNAuthorizedCreditCard;
@class BNCCHostedFormParams;
@class BNPaymentParams;
@class BNHTTPClient;
@class BNAuthenticator;
    
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

///------------------------------------------------
/// @name Setting up handler and access `BNHandler` instance
///------------------------------------------------

/** Setup `BNHandler` with an APIToken.
 *
 * Sets up `BNHandler` with and APIToken that will be used
 * to authenticate the application to the mobivending API
 *
 * @param apiToken Api-token to be used
 * @param error Possible error that can occur during initialization
 */
+ (BOOL)setupWithApiToken:(NSString *)apiToken
                  baseUrl:(NSString *)baseUrl
                    debug:(BOOL)debug
                    error:(NSError **)error;

///------------------------------------------------
/// @name Getting user and app information
///------------------------------------------------

/**
 *  Return the `BNHTTPClient` used by the handler
 *
 *  @return A `BNHTTPClient` associated with the handler
 */
- (BNHTTPClient *)getHttpClient;

/**
 *  Get the API token associated with this `BNHandler`
 *
 *  @return A string representing the API token associated with this `BNHandler`
 */
- (NSString *)getApiToken;

/**
 *  A method for setting an `BNAuthenticator`. This method can be
 *  used if you can retrieve a `BNAuthenticator` from a different source
 *  than the registerUser method.
 *
 *  @param authenticator The `BNAuthenticator` to register
 */
- (void)registerAuthenticator:(BNAuthenticator *)authenticator;

/**
 *  Get the `BNAuthenticator` object associated with this instance
 *
 *  @return A `BNAuthenticator` associated with this instance
 */
- (BNAuthenticator *)authenticator;

/**
 *  A method for checking if the SDK has regitered `BNAuthenticator`
 *
 *  @return A boolean indicating whether or not the SDK has a registered `BNAuthenticator`
 */
- (BOOL)isRegistered;

/**
 *  Get the base URL for the backend
 *
 *  @return A `NSString` cotaining the base URL
 */
- (NSString *)getBaseUrl;

/**
 *  Get debug flag value
 *
 *  @return A `BOOL` indicating if lib is in debug mode
 */
- (BOOL)debugMode;

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
