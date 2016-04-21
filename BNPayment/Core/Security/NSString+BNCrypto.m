//
//  NSString+BPSCrypto.m
//  Pods
//
//  Created by Oskar Henriksson on 17/03/2016.
//
//

#import "NSString+BNCrypto.h"
#import "BNCrypto.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (BPSCrypto)

- (NSString *)AES128EncryptWithKey:(NSData *)key {
    NSError *error;
    NSData *encryptedData = [BNCrypto AES128Data:[self dataUsingEncoding:NSUTF8StringEncoding]
                                             key:key
                                       operation:BNCryptoModeEncrypt
                                           error:&error];
    
    if(!error) {
        return [encryptedData base64EncodedStringWithOptions:0];
    }
    
    return nil;
}

- (NSString *)AES128DecryptWithKey:(NSData *)key {
    NSError *error;

    NSData *encryptedData = [BNCrypto AES128Data:[[NSData alloc] initWithBase64EncodedString:self options:0]
                                             key:key
                                       operation:BNCryptoModeDecrypt
                                           error:&error];
    
    if(!error) {
        return [[NSString alloc] initWithData:encryptedData
                                     encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

- (NSData *)getCertData {
    NSString *certString = self.copy;
    
    certString = [certString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    certString = [certString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    certString = [certString stringByReplacingOccurrencesOfString:@"-----BEGIN CERTIFICATE-----" withString:@""];
    certString = [certString stringByReplacingOccurrencesOfString:@"-----END CERTIFICATE-----" withString:@""];
    
    return [[NSData alloc] initWithBase64EncodedString:certString options:0];;
}

@end
