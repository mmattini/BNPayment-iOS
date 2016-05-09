//
//  BNHTTPResponseSerializer.h
//
//  Created by Bambora On Mobile AB on 21/01/2016.
//

@import Foundation;

@interface BNHTTPResponseSerializer : NSObject

/**
 *  Creates a response object from a `NSURLResponse`.
 *  `BNHTTPResponseSerializer` only supports JSON serialization at the moment.
 *
 *  @param response `NSURLResponse` to be serialized.
 *  @param data     `NSData` to be decoded to a responseObject.
 *  @param error    `NSError` representing an eventual error during the serialization.
 *
 *  @return A response object decoded from the data.
 */
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError **)error;

@end
