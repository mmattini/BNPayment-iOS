//
//  NSString+BNStringUtils.h
//  Pods
//
//  Created by Bambora On Mobile AB on 16/09/2015.
//
//

#import <Foundation/Foundation.h>

@interface NSString (BNStringUtils)

/**
 *  This methods converts hexadecimal bytes to a String representing the bytes
 *
 *  @param bytes  Bytes to be converted to string
 *  @param length Length of the string
 *
 *  @return A `NSString` representing a string representation of hexadecimal bytes
 */

+ (NSString *)hexadecimalByteString:(unsigned char*)bytes length:(NSInteger)length;

@end
