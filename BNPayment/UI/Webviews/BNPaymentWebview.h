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
    BNPWVOperationFetchURL,     // Fetches a URL to load in the webview.
    BNPWVOperationLoadURL,      // Load the URL recieved in the webview.
    BNPWVOperationSubmitCCData  // The user submits the credit card form.
} BNPaymentWebviewOperation;

@protocol BNPaymentWebviewDelegate <NSObject>

/**
 *  An authorized card is registered.
 *
 *  @param webview        The webview that contains the form.
 *  @param authorizedCard The actual authorized card registered.
 */
- (void)BNPaymentWebview:(BNPaymentWebview *)webview didRegisterAuthorizedCard:(BNAuthorizedCreditCard *)authorizedCard;

/**
 *  An operation did start.
 *
 *  @param webview        The webview that contains the form.
 *  @param operation      The operation started.
 */
- (void)BNPaymentWebview:(BNPaymentWebview *)webview didStartOperation:(BNPaymentWebviewOperation)operation;

/**
 *  An operation did finish successfully.
 *
 *  @param webview        The webview that contains the form.
 *  @param operation      The operation that finished.
 */
- (void)BNPaymentWebview:(BNPaymentWebview *)webview didFinishOperation:(BNPaymentWebviewOperation)operation;

/**
 *  An operation did fail
 *
 *  @param webview        The webview that contains the form.
 *  @param operation      The operation that failed.
 *  @param error          The error that occured.
 */
- (void)BNPaymentWebview:(BNPaymentWebview *)webview didFailOperation:(BNPaymentWebviewOperation)operation withError:(NSError *)error;

@end

@interface BNPaymentWebview : WKWebView

@property (nonatomic, weak) id <BNPaymentWebviewDelegate> delegate;

/**
 *  Load the webview form with the `BNCCHostedFormParams` specified as input parameter.
 *
 *  @param params Params used to configure the form.
 */
- (void)loadPaymentWebviewWithParams:(BNCCHostedFormParams *)params;

@end
