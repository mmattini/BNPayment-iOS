//
//  BNCertificateEndpoint.m
//  BNPayment
//
//  Created by Oskar Henriksson on 19/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import "BNCertificateEndpoint.h"
#import "BNEncryptionCertificate.h"
#import <BNBase/BNHandler.h>

@implementation BNCertificateEndpoint

+ (NSURLSessionDataTask *)requestEncryptionCertificatesWithCompletion:(BNEncryptionCertsRequestBlock) completion {
    BNHTTPClient *httpClient = [[BNHandler sharedInstance] getHttpClient];
    
    NSString *endpointURL = @"encryptionCertificates/";
    
    NSURLSessionDataTask *dataTask = [httpClient POST:endpointURL
                                           parameters:nil
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *response;

        for(NSDictionary *dict in responseObject) {
            NSError *error;
            BNEncryptionCertificate *cert = [[BNEncryptionCertificate alloc] initWithJSONDictionary:dict error:&error];
            if(cert && !error) {
                [response addObject:cert];
            }
        }
        completion(response, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
    
    return dataTask;
}

@end
