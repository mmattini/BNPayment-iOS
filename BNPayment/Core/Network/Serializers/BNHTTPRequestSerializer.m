//
//  BNHTTPRequestSerializer.m
//  Pods
//
//  Created by Bambora On Mobile AB on 16/09/2015.
//
//

#import "BNHTTPRequestSerializer.h"
#import "BNHandler.h"
#import "BNUtils.h"
#import "NSDate+BNUtils.h"

@interface BNHTTPRequestSerializer ()

@property (readwrite, nonatomic, strong) NSSet *HTTPMethodsWithQueryParams;

@end

@implementation BNHTTPRequestSerializer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.HTTPMethodsWithQueryParams = [NSSet setWithObjects:@"GET", @"DELETE", nil];
    }
    return self;
}

- (NSURLRequest *)requestWithMethod:(NSString *)method
                          URLString:(NSString *)URLString
                         parameters:(NSDictionary *)parameters
                              error:(NSError **)error {
    
    BNHandler *handler = [BNHandler sharedInstance];
    
    NSURLRequest *request = [self createRequestWithMethod:method
                                                URLString:URLString
                                               parameters:parameters
                                                 apiToken:[handler getApiToken]
                                                    error:error];
    
    if ([handler authenticator]) {
        return [self addAuthHeaderWithRequest:request
                                authenticator:[handler authenticator]];
    }

    return request;
}

- (NSURLRequest *)requestWithApiToken:(NSString *)apiToken
                              request:(NSURLRequest *)request {
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    return mutableRequest;
}

- (NSURLRequest *)createRequestWithMethod:(NSString *)method
                                URLString:(NSString *)url
                               parameters:(NSDictionary *)parameters
                                 apiToken:(NSString *)apiToken
                                    error:(NSError **)error {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:method];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    if ( apiToken) {
        [request setValue:apiToken forHTTPHeaderField:@"Api-Token"];
    }
    
    if ([self.HTTPMethodsWithQueryParams containsObject:[[request HTTPMethod] uppercaseString]]) {
        return [self request:request
                 queryParams:parameters
                       error:error];
    }
    
    return [self request:request
              bodyParams:parameters
                   error:error];
}

- (NSURLRequest *)request:(NSURLRequest *)request
               bodyParams:(NSDictionary *)parameters
                    error:(NSError **)error {
    
    if (parameters) {
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        
        [mutableRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters
                                                                    options:kNilOptions error:error]];

        return mutableRequest;
    }
    

    return request;
}

- (NSURLRequest *)request:(NSURLRequest *)request
              queryParams:(NSDictionary *)parameters
                    error:(NSError **)error {
    
    if (parameters) {
        NSURLComponents *URLComponents = [NSURLComponents componentsWithURL:request.URL
                                                    resolvingAgainstBaseURL:NO];

        NSMutableArray *queryItems = [NSMutableArray new];
        
        [parameters enumerateKeysAndObjectsUsingBlock: ^(id key,
                                                         id obj,
                                                         BOOL *stop) {
            NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:key value:obj];
            [queryItems addObject:queryItem];
        }];
        
        [URLComponents setQueryItems:queryItems];
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        [mutableRequest setURL:URLComponents.URL];

        return mutableRequest;
    }
    
    return request;
}

- (NSURLRequest *)addAuthHeaderWithRequest:(NSURLRequest *)request
                             authenticator:(BNAuthenticator *)authenticator {
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    NSString *dateHeader = [NSDate getDateHeaderFormattedStringForDate:[NSDate date]];
    NSString *httpBody = [[NSString alloc] initWithData:[request HTTPBody]
                                               encoding:NSUTF8StringEncoding];
    NSString *path = [request.URL.path stringByAppendingString:@"/"];
    NSString *queryString = request.URL.query;
    
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
