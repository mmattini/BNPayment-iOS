//
//  NSURLRequest+BNAuth.m
//  BNPayment
//
//  Created by Oskar Henriksson on 09/05/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

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
