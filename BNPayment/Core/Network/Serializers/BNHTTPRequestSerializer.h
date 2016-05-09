//
//  BNHTTPRequestSerializer.h
//
//  Created by Bambora On Mobile AB on 16/09/2015.
//

@import Foundation;

/**
 *  `BNHTTPRequestSerializer` is a class that exents `NSObject`.
 *  `BNHTTPRequestSerializer` only supports JSON serialization at the moment.
 *  `BNHTTPRequestSerializer` will add the Api-Token and auth header to the request
 *  if a `BNAuthenticator` is registered in the `BNHandler`.
 */
@interface BNHTTPRequestSerializer : NSObject

/**
 *  Creates an `NSURLRequest` object with the specified HTTP method and URL string.
 *
 *  @param method     The HTTP method for this `NSURLRequest`. [GET, POST, PUT, DELETE]
 *  @param URLString  The URL to the enpoint which will be appended to the base URL.
 *  @param parameters A dictionary of params to be added to the request.
 *  @param error      An error showing possible errors while creating the request.
 *
 *  @return A `NSURLRequest` to be executed.
 */
- (NSURLRequest *)requestWithMethod:(NSString *)method
                          URLString:(NSString *)URLString
                         parameters:(NSDictionary *)parameters
                              error:(NSError **)error;

@end
