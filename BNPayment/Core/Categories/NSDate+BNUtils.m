//
//  NSDate+BNUtils.m
//  Pods
//
//  Created by Bambora On Mobile AB on 22/09/2015.
//
//

#import "NSDate+BNUtils.h"

@implementation NSDate (BNUtils)

+ (NSString *)getDateHeaderFormattedStringForDate:(NSDate *)date {
    
    //Sun, 06 Nov 1994 08:49:37 GMT
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"EN"];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:locale];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
    
    return [dateFormatter stringFromDate:date];
}
@end
