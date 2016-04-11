//
//  AppDelegate.m
//  BNPayment-Example
//
//  Created by Oskar Henriksson on 07/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import "AppDelegate.h"
#import <BNBase/BNBase.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSError *error;
    [BNHandler setupWithApiToken:@"hOzaNv9mnS60FimU8jMn"
                         baseUrl:@"https://ironpoodle-prod-eu-west-1.aws.bambora.com/"
                           debug:YES
                           error:&error];
    
    if(![[BNHandler sharedInstance] isRegistered]) {
        [[BNHandler sharedInstance] registerUser:nil completion:^(BOOL success) {}];
    }
    
    return YES;
}

@end
