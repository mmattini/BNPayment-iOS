//
//  AppDelegate.m
//  BNPayment-Example
//
//  Created by Bambora On Mobile AB on 11/12/2015.
//  Copyright (c) 2015 Bambora On Mobile AB. All rights reserved.
//

#import "AppDelegate.h"
#import "BNPayment/BNPayment.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSError *error;
    [BNPaymentHandler setupWithMerchantAccount:@"T638003301" // This is a public test merchant number which should be replaced once you have your own.
                                       baseUrl:nil
                                         debug:YES
                                         error:&error];
    
    return YES;
}

@end
