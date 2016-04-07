//
//  BNBundleUtils.h
//  Pods
//
//  Created by Bambora On Mobile AB on 03/02/2016.
//
//

#import <Foundation/Foundation.h>

@interface BNBundleUtils : NSObject

/**
 *  Get bundle for payment sdk.
 *
 *  @return `NSBundle` is the bundle for the payment SDK.
 */
+ (NSBundle *)paymentLibBundle;

/**
 *  Get bundle for name.
 *
 *  @param name The name of the bundle.
 *
 *  @return `NSBundle` is a bundle with that name.
 */
+ (NSBundle *)bundleWithName:(NSString *)name;

/**
 *  Get bundle for a specific class.
 *
 *  @param bundleClass Class which to get bundle for.
 *
 *  @return `NSBundle` is the bundle for that class.
 */
+ (NSBundle *)bundleForClass:(Class)bundleClass;

@end
