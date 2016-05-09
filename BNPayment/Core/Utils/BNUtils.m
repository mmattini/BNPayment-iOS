//
//  BNUtils.m
//  Pods
//
//  Created by Bambora On Mobile AB on 16/09/2015.
//
//

#import "BNUtils.h"
#import "NSString+BNStringUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation BNUtils

+ (NSString *)sha256HMAC:(NSString *)data
                     key:(NSString *)key {
    
    const char *cKey  = key.UTF8String;
    const char *cData = data.UTF8String;
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    if (cKey && cData)
        CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    else return @"";
    
    NSMutableString *output = [NSMutableString stringWithCapacity: CC_SHA256_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat: @"%02x", cHMAC[i]];
    }
    
    return output;
    
}

@end
