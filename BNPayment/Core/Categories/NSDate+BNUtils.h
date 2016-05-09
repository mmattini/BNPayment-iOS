//
//  NSDate+BNUtils.h
//  Pods
//
//  Created by Bambora On Mobile AB on 22/09/2015.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (BNUtils)

/**
 * This is a helper method for converting a Date to a String that can be used
 * in the date http header field. Currently used for generating an auth header.
 *
 * @return A String representation the current date that can be used as a date http header.
 */
+ (NSString *)getDateHeaderFormattedStringForDate:(NSDate *)date;

@end
