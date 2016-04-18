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

- (NSString *)AES256EncryptWithKey:(NSData *)key {
    NSError *error;
    NSData *encryptedData = [BNCrypto AES256Data:[self dataUsingEncoding:NSUTF8StringEncoding]
                                                 key:key
                                           operation:BNCryptoModeEncrypt
                                               error:&error];
    
    if(!error) {
        return [encryptedData base64EncodedStringWithOptions:0];
    }
    
    return nil;
}

- (NSString *)AES256DecryptWithKey:(NSData *)key {
    NSError *error;

    NSData *encryptedData = [BNCrypto AES256Data:[[NSData alloc] initWithBase64EncodedString:self options:0]
                                                 key:key
                                           operation:BNCryptoModeDecrypt
                                               error:&error];
    
    if(!error) {
        return [[NSString alloc] initWithData:encryptedData
                                     encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

@end
