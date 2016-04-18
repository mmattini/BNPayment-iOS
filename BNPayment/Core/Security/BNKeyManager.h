//
//  BNKeyManager.h
//  BNPayment
//
//  Created by Oskar Henriksson on 18/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNKeyManager : NSObject

// Must be of type .cer
+ (SecKeyRef)getPublicKeyRefForFile:(NSString *)filename
                             bundle:(NSBundle *)bundle;

// Must be of type .p12
+ (SecKeyRef)getPrivateKeyRefForFile:(NSString *)filename
                              bundle:(NSBundle *)bundle
                        withPassword:(NSString *)password;

@end
