//
//  BNUser.m
//  Pods
//
//  Created by Bambora On Mobile AB on 11/01/2016.
//
//

#import "BNUser.h"

@implementation BNUser

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"reference" : @"reference",
             @"email" : @"email",
             @"phoneNumber" : @"phone_number",
             @"name" : @"name",
             };
}

@end
