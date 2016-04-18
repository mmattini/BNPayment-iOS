//
//  BPSCrypto.h
//  Pods
//
//  Created by Oskar Henriksson on 17/03/2016.
//
//

@import Foundation;

typedef enum BNCryptoMode : NSUInteger {
    BNCryptoModeEncrypt = 0,
    BNCryptoModeDecrypt
} BNCryptoMode;

@interface BNCrypto : NSObject

+ (NSData *)generateRandomKey:(NSInteger)keyLength;

+ (NSData *)AES256WithData:(NSData *)data
                       key:(NSData *)symmetricKey
                 operation:(BNCryptoMode)operation
                     error:(NSError **)error;

+ (NSData *)RSAEncryptWithData:(NSData *)data
                     key:(SecKeyRef)key;

+ (NSData *)RSADecryptWithData:(NSData *)data
                    key:(SecKeyRef)key;

@end
