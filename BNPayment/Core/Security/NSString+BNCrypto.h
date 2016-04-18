//
//  NSString+BPSCrypto.h
//  Pods
//
//  Created by Oskar Henriksson on 17/03/2016.
//
//

#import <Foundation/Foundation.h>

@interface NSString (BPSCrypto)

- (NSString *)AES256EncryptWithKey:(NSData *)key;
- (NSString *)AES256DecryptWithKey:(NSData *)key;

@end
