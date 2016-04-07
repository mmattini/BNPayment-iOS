//
//  NSURLSessionDataTask+BNUtils.h
//  Pods
//
//  Created by Bambora On Mobile AB on 21/09/2015.
//
//

#import <Foundation/Foundation.h>

@interface NSURLSessionDataTask (BNUtils)

/**
 *  This methods return a HTTP status code from a ´NSURLSessionDataTask´
 *
 *  @return httpStatus ´NSInteger´ indicating the http status of the ´NSURLSessionDataTask´
 */
- (NSInteger) getHttpStatusCode;

@end
