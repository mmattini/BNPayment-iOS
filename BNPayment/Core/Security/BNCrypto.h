//
//  BPSCrypto.h
//  Pods
//
//  Created by Oskar Henriksson on 17/03/2016.
//
//
#import <CommonCrypto/CommonCryptor.h>
#import <Foundation/Foundation.h>

@interface BNCrypto : NSObject

+ (NSData *)generateRandomKey:(NSInteger)keyLength;

+ (NSData *)AES256WithData:(NSData *)data
                       key:(NSData *)symmetricKey
                 operation:(CCOperation)operation
                     error:(NSError **)error;

+ (NSData *)RSAEncryptWithData:(NSData *)data
                     publicKey:(SecKeyRef)publicKey;

+ (NSData *)RSADecryptWithData:(NSData *)data
                    privateKey:(SecKeyRef)privateKey;

@end
