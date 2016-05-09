//
//  BNAuthenticator.m
//  Pods
//
//  Created by Bambora On Mobile AB on 07/01/2016.
//
//

#import "BNAuthenticator.h"

@implementation BNAuthenticator

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"sharedSecret" : @"secret",
             @"uuid" : @"id"
             };
}

@end
