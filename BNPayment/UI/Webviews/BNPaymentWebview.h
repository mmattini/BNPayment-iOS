//
//  BNPaymentWebview.h
//  Pods
//
//  Created by Bambora On Mobile AB on 11/02/2016.
//
//

#import <WebKit/WebKit.h>

@class EPAYHostedFormStateChange;

@protocol BNPaymentWebviewDelegate <NSObject>

/**
 *  A delegate method for capturing state changes within the webview.
 *
 *  @param webview     `WKWebview` the webview calling the delegate.
 *  @param stateChange `BNCCHostedFormStateChange` the statechange.
 */
- (void)webiew:(WKWebView *)webview didReceiveStateChange:(EPAYHostedFormStateChange *)stateChange;

@end

@interface BNPaymentWebview : WKWebView

@property (nonatomic, weak) id <BNPaymentWebviewDelegate> delegate;

@end
