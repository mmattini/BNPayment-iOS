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

+ (NSData *)AES256Data:(NSData *)data
                       key:(NSData *)symmetricKey
                 operation:(BNCryptoMode)operation
                     error:(NSError **)error;

+ (NSData *)RSAEncryptData:(NSData *)data
                       key:(SecKeyRef)key;

+ (NSData *)RSADecryptData:(NSData *)data
                       key:(SecKeyRef)key;

@end
