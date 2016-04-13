//
//  BNPaymentWebview.h
//  Pods
//
//  Created by Bambora On Mobile AB on 11/02/2016.
//
//

@import WebKit;

@class EPAYHostedFormStateChange;
@class BNCCHostedFormParams;
@class BNPaymentWebview;
@class BNAuthorizedCreditCard;

/**
 *  `BNPaymentWebviewOperation`
 */
typedef enum BNPaymentWebviewOperation : NSUInteger {
    BNPWVOperationFetchURL,
    BNPWVOperationLoadURL,
    BNPWVOperationSubmitCCData
} BNPaymentWebviewOperation;

@protocol BNPaymentWebviewDelegate <NSObject>

- (void)BNPaymentWebview:(BNPaymentWebview *)webview didRegisterAuthorizedCard:(BNAuthorizedCreditCard *)authorizedCard;
- (void)BNPaymentWebview:(BNPaymentWebview *)webview didStartOperation:(BNPaymentWebviewOperation)operation;
- (void)BNPaymentWebview:(BNPaymentWebview *)webview didFinishOperation:(BNPaymentWebviewOperation)operation;
- (void)BNPaymentWebview:(BNPaymentWebview *)webview didFailOperation:(BNPaymentWebviewOperation)operation withError:(NSError *)error;

@end

@interface BNPaymentWebview : WKWebView

@property (nonatomic, weak) id <BNPaymentWebviewDelegate> delegate;

- (void)loadPaymentWebviewWithParams:(BNCCHostedFormParams *)params;

@end
