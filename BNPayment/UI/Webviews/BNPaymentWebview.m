//
//  BNPaymentWebview.m
//  Pods
//
//  Created by Bambora On Mobile AB on 11/02/2016.
//
//

#import "BNPaymentWebview.h"
#import "EPAYHostedFormStateChange.h"

@interface BNPaymentWebview () <WKNavigationDelegate, WKScriptMessageHandler>

@end

@implementation BNPaymentWebview

- (instancetype) init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame configuration:[WKWebViewConfiguration new]];
}

- (instancetype)initWithFrame:(CGRect)frame
                configuration:(WKWebViewConfiguration *)configuration {
    configuration.userContentController = [self createUserContentController];
    self = [super initWithFrame:frame configuration:configuration];
    
    return self;
}

- (WKUserContentController *)createUserContentController {
    WKUserContentController *controller = [WKUserContentController new];
    [controller addScriptMessageHandler:self name:@"observe"];
    return controller;
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"\nHPP State change: %@", message.body);
    NSError *error;
    EPAYHostedFormStateChange *stateChange = [[EPAYHostedFormStateChange alloc] initWithJSONDictionary:message.body
                                                                                                 error:&error];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(webiew:didReceiveStateChange:)]) {
        [self.delegate webiew:self didReceiveStateChange:stateChange];
    }

}


@end
