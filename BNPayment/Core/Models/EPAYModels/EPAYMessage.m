//
//  EPAYMessage.m
//  Pods
//
//  Created by Bambora On Mobile AB on 22/02/2016.
//
//

#import "EPAYMessage.h"

@implementation EPAYMessage

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"enduser": @"enduser",
             @"merchant": @"merchant"
             };
}

@end
