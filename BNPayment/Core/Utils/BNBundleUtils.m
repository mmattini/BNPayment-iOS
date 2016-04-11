//
//  BNBundleUtils.m
//  Pods
//
//  Created by Bambora On Mobile AB on 03/02/2016.
//
//

#import "BNBundleUtils.h"

@implementation BNBundleUtils

+ (NSBundle *)paymentLibBundle {
    NSBundle *bundle = [BNBundleUtils bundleWithName:@"BNPayment"];
    
    if (!bundle) {
        bundle = [BNBundleUtils bundleForClass:[BNBundleUtils class]];
    }
    
    return bundle;
}

+ (NSBundle *)bundleWithName:(NSString *)name {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:name
                                                           ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    return bundle;
}

+ (NSBundle *)bundleForClass:(Class)bundleClass {
    return [NSBundle bundleForClass:bundleClass];
}

@end
