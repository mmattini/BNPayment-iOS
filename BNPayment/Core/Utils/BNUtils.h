//
//  BNUtils.h
//  Pods
//
//  Created by Bambora On Mobile AB on 16/09/2015.
//
//

#import <Foundation/Foundation.h>

typedef void (^HashGenerationBlock) (NSString *hash);

@interface BNUtils : NSObject

/**
 *  A method for generating a sha256HMAC from `NSData` with a given `NSString` key
 *
 *  @param data `NSData` representing the data to be sha256HMAC'ed
 *  @param key  `NSString` representing the key used for the HMAC
 *
 *  @return `NSString` representing the data provided HMAC'ed with the key provided
 */
+ (NSString *)sha256HMAC:(NSString *)data
                     key:(NSString *)key;

@end
