//
//  BPSCrypto.m
//  Pods
//
//  Created by Oskar Henriksson on 17/03/2016.
//
//

#import "BNCrypto.h"

@implementation BNCrypto


+ (NSData *)generateRandomKey:(NSInteger)keyLength {
    uint8_t randomBytes[keyLength];
    SecRandomCopyBytes(kSecRandomDefault, keyLength, randomBytes);
    return [NSData dataWithBytes:randomBytes length:sizeof(randomBytes)];
}

+ (NSData *)AES256WithData:(NSData *)data
                       key:(NSData *)symmetricKey
                 operation:(CCOperation)operation
                     error:(NSError **)error {
    
    CCCryptorStatus ccStatus = kCCSuccess;
    size_t cryptBytes = 0;
    
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

+ (NSData *)RSAEncryptWithData:(NSData *)data
                     publicKey:(SecKeyRef)publicKey {
    OSStatus status = noErr;

    size_t dataSize = sizeof(data);
    size_t cipherBufferSize = SecKeyGetBlockSize(publicKey);
    uint8_t *cipherBuffer = malloc(cipherBufferSize);
    
    status = SecKeyEncrypt(publicKey,
                           kSecPaddingPKCS1,
                           data.bytes,
                           dataSize,
                           cipherBuffer,
                           &cipherBufferSize);
    
    NSData *encryptedData = [NSData dataWithBytes:cipherBuffer length:dataSize];
    free(cipherBuffer);

    return encryptedData;
}

+ (NSData *)RSADecryptWithData:(NSData *)data
                    privateKey:(SecKeyRef)privateKey {
    OSStatus status = noErr;
    
    size_t cipherBufferSize = [data length];
    uint8_t *cipherBuffer = (uint8_t *)[data bytes];
    
    size_t plainBufferSize = SecKeyGetBlockSize(privateKey);
    uint8_t *plainBuffer = malloc(plainBufferSize);

    //  Error handling
    status = SecKeyDecrypt(privateKey,
                           kSecPaddingPKCS1,
                           cipherBuffer,
                           cipherBufferSize,
                           plainBuffer,
                           &plainBufferSize);
    
    NSData *encryptedData = [NSData dataWithBytes:plainBuffer length:plainBufferSize];

    return encryptedData;
}

@end
