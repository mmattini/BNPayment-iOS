//
//  BNPaymentHandler.h
//  Copyright (c) 2016 Bambora ( http://bambora.com/ )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "BNEnums.h"
#import "BNCreditCardEndpoint.h"

@import Foundation;

@class BNAuthorizedCreditCard;
@class BNCCHostedFormParams;
@class BNAuthorizedCreditCard;
@class BNRegisterCCParams;
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
/// @name Setting up handler and access `BNPaymentHandler` instance
///------------------------------------------------

/** Setup `BNPaymentHandler` with an APIToken.
 *
 * Sets up `BNPaymentHandler` with and APIToken that will be used
 * to authenticate the application to the back end.
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
 *  Get the API token associated with this `BNPaymentHandler`
 *
 *  @return A string representing the API token associated with this `BNPaymentHandler`
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
 *  A method for refeshing the encryption certs
 */
- (void)refreshCertificates;

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
 *  Register a credit card in order to retrieve an authroized card used for payments.
 *
 *  @param params     `BNRegisterCCParams`
 *  @param completion `BNCreditCardRegistrationBlock`
 *
 *  @return `NSURLSessionDataTask`
 */
- (NSURLSessionDataTask *)registerCreditCard:(BNRegisterCCParams *)params
                                  completion:(BNCreditCardRegistrationBlock)completion;

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
