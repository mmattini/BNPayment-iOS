//
//  BNAuthenticator.h
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
