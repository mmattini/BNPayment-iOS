//
//  BNHandler.h
//  Pods
//
//  Created by Bambora On Mobile AB on 16/09/2015.
//
//

#import <Foundation/Foundation.h>
#import "BNUser.h"
#import "BNAuthenticator.h"
#import "BNHttpClient.h"

@interface BNHandler : NSObject

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

/** 
 * Return `BNHandler` shared instance creating it if necessary.
 *
 * @return The shared `BNHandler` instance
 */
+ (BNHandler *)sharedInstance;

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
 *  A method for registering an user. Call this method to register an
 *  user and generate a `BNAuthenticator` class to be used for authentication.
 *  Then handler will store the `BNAuthenticator` for you.
 *
 *  @param user    A `BNUser` to be used for the registration.
 *  @param success A block indicating the result of the operation.
 */
- (void)registerUser:(BNUser *)user completion:(void (^) (BOOL))success;

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

@end
