//
//  BNAuthenticator.h
//  Pods
//
//  Created by Bambora On Mobile AB on 07/01/2016.
//

#import "BNBaseModel.h"

/**
 * `BNAuthenticator` is used for authenticating all request to the backend.
 * Without a registered authenticator you are not authorized to communicate with the backend.
 * A `BNAuthenticator` can either be provided by the SDK user or obtained in the registration process.
 */
@interface BNAuthenticator : BNBaseModel

///------------------------------------------------
/// @name Properties
///------------------------------------------------

/**
 * Shared secret for authentication as a key for the generated HMAC
 */
@property (strong, nonatomic) NSString *sharedSecret;

/**
 * A generated uuid for the app registration
 */
@property (strong, nonatomic) NSString *uuid;

@end
