//
//  BPSCrypto.m
//  Pods
//
//  Created by Oskar Henriksson on 17/03/2016.
//
//

#import "BNCrypto.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation BNCrypto


+ (NSData *)generateRandomKey:(NSInteger)keyLength {
    uint8_t randomBytes[keyLength];
    SecRandomCopyBytes(kSecRandomDefault, keyLength, randomBytes);
    return [NSData dataWithBytes:randomBytes length:sizeof(randomBytes)];
}

+ (NSData *)AES256Data:(NSData *)data
                   key:(NSData *)symmetricKey
             operation:(BNCryptoMode)operation
                 error:(NSError **)error {
    CCCryptorStatus ccStatus;
    size_t cryptBytes;
    
    NSMutableData *dataOut = [NSMutableData dataWithLength:data.length + kCCBlockSizeAES128];
    
    ccStatus = CCCrypt(operation,
                       kCCAlgorithmAES,
                       kCCOptionPKCS7Padding,
                       symmetricKey.bytes,
                       kCCKeySizeAES256,
                       symmetricKey.bytes,
                       data.bytes,
                       data.length,
                       dataOut.mutableBytes,
                       dataOut.length,
                       &cryptBytes);
    
    if (ccStatus == kCCSuccess) {
        dataOut.length = cryptBytes;
    }else {
        if (error) {
            *error = [NSError errorWithDomain:@"kEncryptionError" code:ccStatus userInfo:nil];
        }
        dataOut = nil;
    }
    
    return dataOut;
}

+ (NSData *)RSAEncryptData:(NSData *)data
                     key:(SecKeyRef)key {
    OSStatus status = noErr;

    // Input
    size_t plainDataSize = [data length];
    uint8_t *plainData = (uint8_t *)[data bytes];

    // Output
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize);

    status = SecKeyEncrypt(key,
                           kSecPaddingPKCS1,
                           plainData,
                           plainDataSize,
                           cipherBuffer,
                           &cipherBufferSize);
    
    if(status != noErr) {
        free(cipherBuffer);
        return nil;
    }
    
    NSData *encryptedData = [NSData dataWithBytes:cipherBuffer length:cipherBufferSize];
    free(cipherBuffer);

    return encryptedData;
}

+ (NSData *)RSADecryptData:(NSData *)data
                    key:(SecKeyRef)key {
    OSStatus status = noErr;
    
    // Input
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = (uint8_t *)[data bytes];
    
    // Output
    size_t plainBufferSize = SecKeyGetBlockSize(key);
    uint8_t *plainBuffer = malloc(plainBufferSize);

    status = SecKeyDecrypt(key,
                           kSecPaddingPKCS1,
                           cipherBuffer,
                           cipherBufferSize,
                           plainBuffer,
                           &plainBufferSize);
    
    if(status != noErr) {
        free(plainBuffer);
        return nil;
    }
    
    NSData *decryptedData = [NSData dataWithBytes:plainBuffer length:plainBufferSize];
    free(plainBuffer);

    return decryptedData;
}

@end
