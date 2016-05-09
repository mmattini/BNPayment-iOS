//
//  BNHTTPRequestSerializer.m
//  Pods
//
//  Created by Bambora On Mobile AB on 16/09/2015.
//
//

#import "BNHTTPRequestSerializer.h"
#import "BNPaymentHandler.h"
#import "BNUtils.h"
#import "NSDate+BNUtils.h"
#import "BNAuthenticator.h"
#import "NSURLRequest+BNAuth.h"

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
    
    BNPaymentHandler *handler = [BNPaymentHandler sharedInstance];
    
    NSURLRequest *request = [self createRequestWithMethod:method
                                                URLString:URLString
                                               parameters:parameters
                                                 apiToken:[handler getApiToken]
                                                    error:error];
    
    if ([handler authenticator]) {
        return [request addAuthHeaderWithAuthenticator:[handler authenticator]];
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

@end
