//
//  NSString+BNStringUtils.m
//  Pods
//
//  Created by Bambora On Mobile AB on 16/09/2015.
//
//

#import "NSString+BNStringUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (BNStringUtils)

+ (NSString*)hexadecimalByteString:(unsigned char*)bytes length:(NSInteger)length {
    NSMutableString *output = [NSMutableString stringWithCapacity:length * 2];
    
    for (int i = 0; i < length; i++) {
        [output appendFormat:@"%02x", bytes[i]];
    }
    
    return output;
}

@end
