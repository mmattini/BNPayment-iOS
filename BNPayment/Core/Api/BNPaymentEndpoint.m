//
//  BNTransactionEndpoint.m
//  Pods
//
//  Created by Bambora On Mobile AB on 17/09/2015.
//
//

#import "BNPaymentEndpoint.h"
#import "BNPaymentParams.h"
#import "BNPaymentResponse.h"
#import "BNPaymentHandler.h"
#import <BNBase/BNHandler.h>

@implementation BNPaymentEndpoint

+ (NSURLSessionDataTask *)authorizePaymentWithParams:(BNPaymentParams *)params
                                          completion:(BNPaymentRequestBlock) completion {
        BNHTTPClient *httpClient = [[BNHandler sharedInstance] getHttpClient];
    
    NSString *endPointUrl = [NSString stringWithFormat:@"payments/%@/card_token/", params.paymentIdentifier];
    
    NSURLSessionDataTask *dataTask = [httpClient POST:endPointUrl
                                           parameters:[params JSONDictionary]
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error;
        BNPaymentResponse *response = [[BNPaymentResponse alloc] initWithJSONDictionary:responseObject
                                                                                  error:&error];
        completion(response, error);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
    
    return dataTask;
}

@end
