//
//  NSString+BPSCrypto.h
//  Pods
//
//  Created by Oskar Henriksson on 17/03/2016.
//
//

#import <Foundation/Foundation.h>

@interface NSString (BPSCrypto)

/**
 *  A helper method which encrypts the string with a given
 *  AES256 key and returns a base64 encoded representation
 *  of the encrypted string.
 *
 *  @param key `NSData` used as a key for the encryption.
 *
 *  @return `NSString` AES256 encryptet string with key and base64 ecoded.
 */
- (NSString *)AES256EncryptWithKey:(NSData *)key;

/**
 *  A helper method which decrypts a base64 endoded encrypted string
 *  and return the original string.
 *
 *  @param key `NSData` used as a key for the decryption.
 *
 *  @return `NSString` AES256 decrypted string UTF8 encoded.
 */
- (NSString *)AES256DecryptWithKey:(NSData *)key;

@end
