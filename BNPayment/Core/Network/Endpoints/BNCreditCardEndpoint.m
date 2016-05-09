//
//  BNCreditCardEndpoint.m
//  Pods
//
//  Created by Bambora On Mobile AB on 17/09/2015.
//
//

#import "BNCreditCardEndpoint.h"
#import "BNCCHostedFormParams.h"
#import "BNPaymentHandler.h"
#import "BNHTTPClient.h"

@implementation BNCreditCardEndpoint

+ (NSURLSessionDataTask *)initiateCreditCardRegistrationForm:(BNCCHostedFormParams *)formParams
                                                  completion:(BNCreditCardUrlBlock) block {
    BNHTTPClient *httpClient = [[BNPaymentHandler sharedInstance] getHttpClient];
    
    NSString *endPointUrl = @"hpp/";
    
    NSDictionary *params = [formParams JSONDictionary];
    
    NSURLSessionDataTask *dataTask = [httpClient POST:endPointUrl
                                           parameters:params
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *url = [responseObject objectForKey:@"session_url"];
        block(url, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
    
    return dataTask;
}

@end
