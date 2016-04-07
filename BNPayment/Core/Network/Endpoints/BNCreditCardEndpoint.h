//
//  BNCreditCardEndpoint.h
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

#import "BNPaymentHandler.h"

@class BNCCHostedFormParams;

/**
 *  A block object to be executed when a credit card registration operation has completed.
 *  The block return an String containing the url to load in order to register a credit card
 *  `NSError` representing the error recieved. error is nil is operation is successful.
 *
 *  @param url `NSString`
 *  @param error `NSError`
 */
typedef void (^BNCreditCardUrlBlock)(NSString *url, NSError *error);

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
                                                  completion:(BNCreditCardUrlBlock)block;

@end
