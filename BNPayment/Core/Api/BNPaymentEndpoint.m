//
//  BNTransactionEndpoint.m
//  Pods
//
//  Created by Bambora On Mobile AB on 17/09/2015.
//
//

#import "BNPaymentEndpoint.h"
#import "BNHandler.h"
#import "BNError.h"
#import "BNPaymentParams.h"
#import "BNPaymentResponse.h"
#import "BNPaymentHandler.h"

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
        completion(response, error ? [[BNError alloc] initWithTask:task error:error] : nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, [[BNError alloc] initWithTask:task error:error]);
    }];
    
    return dataTask;
}

@end
