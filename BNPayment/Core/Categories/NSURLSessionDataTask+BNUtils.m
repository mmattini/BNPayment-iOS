//
//  NSURLSessionDataTask+BNUtils.m
//  Pods
//
//  Created by Bambora On Mobile AB on 21/09/2015.
//
//

#import "NSURLSessionDataTask+BNUtils.h"

@implementation NSURLSessionDataTask (BNUtils)

- (NSInteger) getHttpStatusCode {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)self.response;
    return response.statusCode;
}

@end
