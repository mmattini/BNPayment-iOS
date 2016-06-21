//
//  BNRegistrationEndpoint.h
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

#import <Foundation/Foundation.h>

@class BNUser;
@class BNAuthenticator;

/**
 *  A block object to be executed when a SDK registration request has completed.
 *
 *  @param authenticator `BNAuthenticator` representing the response object recieved.
 *  @param error         `BNError` representing an error that occured during the registration operation.
 */
typedef void (^BNRegistrationBlock)(BNAuthenticator *authenticator, NSError *error);

@interface BNRegistrationEndpoint : NSObject

/**
 *  Register an user to the SDK in order to recieve a `BNAuthenticator` used for authenticating 
 *  all request to the back end.
 *
 *  @param user  `BNUser` representing the params to include in the operation.
 *  @param block `BNRegistrationBlock` to be executed when the operation finishes.
 */
+ (NSURLSessionDataTask *)registerWithUser:(BNUser *)user
                                completion:(BNRegistrationBlock)completion;

@end
