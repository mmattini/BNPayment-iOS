//
//  BNCreditCardEndpoint.m
//  Pods
//
//  Created by Bambora On Mobile AB on 17/09/2015.
//
//

#import "BNCreditCardEndpoint.h"
#import "BNCCHostedFormParams.h"
#import "BNRegisterCCParams.h"
#import "BNAuthorizedCreditCard.h"
#import "BNPaymentHandler.h"
#import "BNHTTPClient.h"

@implementation BNCreditCardEndpoint

+ (NSURLSessionDataTask *)initiateCreditCardRegistrationForm:(BNCCHostedFormParams *)formParams
                                                  completion:(BNCreditCardUrlBlock)completion {
    BNHTTPClient *httpClient = [[BNPaymentHandler sharedInstance] getHttpClient];
    
    NSString *endpointUrl = @"hpp/";
    
    NSDictionary *params = [formParams JSONDictionary];
    
    NSURLSessionDataTask *dataTask = [httpClient POST:endpointUrl
                                           parameters:params
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *url = [responseObject objectForKey:@"session_url"];
        completion(url, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
    
    return dataTask;
}

+ (NSURLSessionDataTask *)registerCreditCard:(BNRegisterCCParams *)params
                                  completion:(BNCreditCardRegistrationBlock)completion {
    BNHTTPClient *httpClient = [[BNPaymentHandler sharedInstance] getHttpClient];
    
    NSString *endpointURL = @"cardregistration/";
    NSDictionary *requestParams = [params JSONDictionary];
    
    NSURLSessionDataTask *dataTask = [httpClient POST:endpointURL parameters:requestParams success:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error;
        BNAuthorizedCreditCard *response = [[BNAuthorizedCreditCard alloc] initWithJSONDictionary:responseObject
                                                                                  error:&error];
        completion(response, error);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
    
    return dataTask;
}

+ (NSURLSessionDataTask *)encryptionCertificatesWithCompletion:(BNEncryptionCertBlock)completion {
    BNHTTPClient *httpClient = [[BNPaymentHandler sharedInstance] getHttpClient];
    
    NSString *endpointURL = @"certificates/";
    
    NSURLSessionDataTask *dataTask = [httpClient GET:endpointURL parameters:[NSDictionary new] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error;
        /*
        BNAuthorizedCreditCard *response = [[BNAuthorizedCreditCard alloc] initWithJSONDictionary:responseObject
                                                                                            error:&error];
         */
        completion(responseObject, error);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
    
    return dataTask;
}

@end
