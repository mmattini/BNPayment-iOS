//
//  NSURLRequest+BNAuth.m
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

#import "NSURLRequest+BNAuth.h"
#import "BNAuthenticator.h"
#import "NSDate+BNUtils.h"
#import "BNUtils.h"

@implementation NSURLRequest (BNAuth)

- (NSURLRequest *)addAuthHeaderWithAuthenticator:(BNAuthenticator *)authenticator {
    NSMutableURLRequest *mutableRequest = [self mutableCopy];
    
    NSString *dateHeader = [NSDate getDateHeaderFormattedStringForDate:[NSDate date]];
    NSString *httpBody = [[NSString alloc] initWithData:[self HTTPBody]
                                               encoding:NSUTF8StringEncoding];
    NSString *path = [self.URL.path stringByAppendingString:@"/"];
    NSString *queryString = self.URL.query;
    
    NSString *authHeader = [self generateAuthHeaderForUUID:authenticator.uuid ? authenticator.uuid : @""
                                                dateHeader:dateHeader ? dateHeader : @""
                                                      path:path ? path : @""
                                               queryString:queryString ? queryString : @""
                                                      body:httpBody ? httpBody : @""
                                              sharedSecret:authenticator.sharedSecret ? authenticator.sharedSecret : @""];
    
    [mutableRequest setValue:authHeader forHTTPHeaderField:@"Authorization"];
    [mutableRequest setValue:dateHeader forHTTPHeaderField:@"Date"];
    
    return mutableRequest;
}

- (NSString *)generateAuthHeaderForUUID:(NSString *)uuid
                             dateHeader:(NSString *)dateHeader
                                   path:(NSString *)path
                            queryString:(NSString *)queryString
                                   body:(NSString *)body
                           sharedSecret:(NSString *)sharedSecret {
    
    NSString *stringToHash = [@[uuid, body, dateHeader, path, queryString] componentsJoinedByString: @":"];
    NSString *hmac = [BNUtils sha256HMAC:stringToHash key:sharedSecret];
    NSString *authHeader = [NSString stringWithFormat:@"MPS1 %@:%@", uuid, hmac];
    
    return authHeader;
}

@end
