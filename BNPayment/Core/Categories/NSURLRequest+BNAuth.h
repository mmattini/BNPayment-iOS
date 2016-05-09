//
//  NSURLRequest+BNAuth.h
//  BNPayment
//
//  Created by Oskar Henriksson on 09/05/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNAuthenticator;

@interface NSURLRequest (BNAuth)

- (NSURLRequest *)addAuthHeaderWithAuthenticator:(BNAuthenticator *)authenticator;

@end
