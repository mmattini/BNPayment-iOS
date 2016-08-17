//
//  NSDate+BNUtils.h
//  Copyright (c) 2016 Bambora ( http://bambora.com/ )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>

@interface NSDate (BNUtils)

/**
 * This is a helper method for converting a Date to a String that can be used
 * in the date http header field. Currently used for generating an auth header.
 *
 * @return A String representating the current date that can be used as a date http header.
 */
+ (NSString *)getDateHeaderFormattedStringForDate:(NSDate *)date;

/**
 *  This is a helper method for parsing a ISO 8601 formatted string.
 *
 *  @param dateString `NSString` in ISO 8601 format.
 *
 *  @return `NSDate` parsed from a ISO 8601 string.
 */
+ (NSDate *)dateFromISO8601String:(NSString *)dateString;

@end
