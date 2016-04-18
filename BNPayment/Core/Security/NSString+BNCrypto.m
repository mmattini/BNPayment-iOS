//
//  NSString+BPSCrypto.m
//  Pods
//
//  Created by Oskar Henriksson on 17/03/2016.
//
//

#import "NSString+BNCrypto.h"
#import "BNCrypto.h"

@implementation NSString (BPSCrypto)

- (NSString *)AES256EncryptWithKey:(NSData *)key {
    NSError *error;
    NSData *encryptedData = [BNCrypto AES256WithData:[self dataUsingEncoding:NSUTF8StringEncoding] key:key operation:kCCEncrypt error:&error];
    
    if(!error) {
        return [encryptedData base64EncodedStringWithOptions:0];
    }
    
    return nil;
}

- (NSString *)AES256DecryptWithKey:(NSData *)key {
    NSError *error;

    NSData *encryptedData = [BNCrypto AES256WithData:[[NSData alloc] initWithBase64EncodedString:self options:0] key:key operation:kCCDecrypt error:&error];
    
    if(!error) {
        return [[NSString alloc] initWithData:encryptedData encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

@end
