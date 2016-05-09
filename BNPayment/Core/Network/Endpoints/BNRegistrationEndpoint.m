//
//  BNSdkRegistrationEndpoint.m
//  Pods
//
//  Created by Bambora On Mobile AB on 08/01/2016.
//
//

#import "BNRegistrationEndpoint.h"
#import "BNHandler.h"
#import "BNUser.h"
#import "BNAuthenticator.h"

static NSString *const RegistrationEndpointUrl = @"credentials/";

@implementation BNRegistrationEndpoint

+ (NSURLSessionDataTask *)registerWithUser:(BNUser *)user
                                completion:(BNRegistrationBlock)completion {
    BNHTTPClient *httpClient = [[BNHandler sharedInstance] getHttpClient];
    
    NSURLSessionDataTask *task = [httpClient POST:RegistrationEndpointUrl
                                       parameters:[user JSONDictionary]
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error;
        BNAuthenticator *authenticator = [[BNAuthenticator alloc] initWithJSONDictionary:responseObject error:&error];
        completion(authenticator, error);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
    
    return task;
}

@end
