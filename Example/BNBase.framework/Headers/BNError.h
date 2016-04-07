//
//  BNError.h
//  Pods
//
//  Created by Bambora On Mobile AB on 21/09/2015.
//
//

#import <Foundation/Foundation.h>

/**
 `BNError` is an internal class to represent errors. Currently only hold two properties but can be extended in the future.
 */
@interface BNError : NSObject

///------------------------------------------------
/// @name Initialization
///------------------------------------------------

/** Setup `BNError` with an `NSURLSessionDataTask` task and a `NSError`.
 *
 * Setup `BNError` with an `NSURLSessionDataTask` task and a `NSError`.
 *
 * @param task A `NSURLSessionDataTask` used to gather information about the error
 * @param error The error to be included in the `BNError`
 */
- (instancetype)initWithTask:(NSURLSessionDataTask *)task
                       error:(NSError *)error;

///------------------------------------------------
/// @name Properties
///------------------------------------------------

/**
 The httpStatus code of the error
 */
@property (nonatomic, assign) NSInteger httpStatusCode;

/**
 The NSError provided in the init method
 */
@property (strong, nonatomic) NSError *error;

@end
