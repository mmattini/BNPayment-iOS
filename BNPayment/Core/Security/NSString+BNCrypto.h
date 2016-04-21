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
 *  AES128 key and returns a base64 encoded representation
 *  of the encrypted string.
 *
 *  @param key `NSData` used as a key for the encryption.
 *
 *  @return `NSString` AES128 encryptet string with key and base64 ecoded.
 */
- (NSString *)AES128EncryptWithKey:(NSData *)key;

/**
 *  A helper method which decrypts a base64 endoded encrypted string
 *  and return the original string.
 *
 *  @param key `NSData` used as a key for the decryption.
 *
 *  @return `NSString` AES128 decrypted string UTF8 encoded.
 */
- (NSString *)AES128DecryptWithKey:(NSData *)key;

/**
 *  A method for extracting the data from a string representing a Base64 ecoded
 *  certificate in .pem format.
 *
 *  @return `NSData` representing the certificate.
 */
- (NSData *)getCertData;

@end
