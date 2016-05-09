//
//  NSString+BNLogUtils.m
//  Pods
//
//  Created by Bambora On Mobile AB on 01/03/2016.
//
//

#import "NSString+BNLogUtils.h"

@implementation NSString (BNLogUtils)

+ (NSString *)logentryWithTitle:(NSString *)title message:(NSString *)message {
    NSString *divider = @"-----------------------------------------------";
    NSString *logEntry = [NSString stringWithFormat:@"\n%@\n%@\n%@\n%@\n%@",
                          divider,
                          title,
                          divider,
                          message,
                          divider];
    
    return logEntry;
}

@end
