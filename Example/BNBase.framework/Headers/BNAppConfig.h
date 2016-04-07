//
//  BNAppConfig.h
//  Pods
//
//  Created by Bambora On Mobile AB on 15/09/2015.
//
//
#import "BNBaseModel.h"

/**
 `BNAppConfig` is a class containing configuration values for the registered application.
 `BNAppConfig` is only available after successful registration.
 */
@interface BNAppConfig : BNBaseModel

///------------------------------------------------
/// @name Properties
///------------------------------------------------

/**
 * Shared secret for authentication and HMACed requests
 */
@property (strong, nonatomic) NSString *sharedSecret;

/**
 * App ID
 */
@property (strong, nonatomic) NSNumber *appId;

/**
 * Country ID
 */
@property (strong, nonatomic) NSNumber *countryId;

/**
 * The number of leading (binary) zeroes required in the verification hash
 */
@property (strong, nonatomic) NSNumber *powDifficulty;

/**
 * A generated udid for the app registration
 */
@property (strong, nonatomic) NSString *udid;

@end
