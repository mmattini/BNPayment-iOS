//
//  BNAppConfig.m
//  Pods
//
//  Created by Bambora On Mobile AB on 15/09/2015.
//
//

#import "BNAppConfig.h"

@implementation BNAppConfig

+ (NSDictionary *)JSONMappingDictionary {
  return @{
           @"sharedSecret" : @"shared_secret",
           @"appId" : @"app",
           @"powDifficulty" : @"pow_difficulty",
           @"countryId" : @"country",
           @"udid" : @"uuid"
           };
}

@end
