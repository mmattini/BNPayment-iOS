//
//  BNEPAYMetaResponse.m
//  Pods
//
//  Created by Bambora On Mobile AB on 22/02/2016.
//
//

#import "EPAYMetaResponse.h"
#import "EPAYAction.h"
#import "EPAYMessage.h"

@implementation EPAYMetaResponse

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"action": @"action",
             @"message": @"message",
             @"result": @"result"
             };
}

@end
