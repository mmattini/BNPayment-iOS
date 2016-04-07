//
//  BNRegistrationEndpoint.h
//
//  Created by Bambora On Mobile AB on 08/01/2016.
//

#import <Foundation/Foundation.h>

@class BNError;
@class BNUser;
@class BNAuthenticator;

/**
 *  A block object to be executed when a SDK registration request has completed.
 *
 *  @param authenticator `BNAuthenticator` representing the response object recieved.
 *  @param error         `BNError` representing an error that occured during the registration operation.
 */
typedef void (^BNRegistrationBlock)(BNAuthenticator *authenticator, BNError *error);

@interface BNRegistrationEndpoint : NSObject

/**
 *  Register an user to the SDK in order to recieve a `BNAuthenticator` used for authenticating 
 *  all request to the back end.
 *
 *  @param user  `BNUser` representing the params to include in the operation.
 *  @param block `BNRegistrationBlock` to be executed when the operation finishes.
 */
+ (NSURLSessionDataTask *)registerWithUser:(BNUser *)user
                                     block:(BNRegistrationBlock) block;

@end
