//
//  BNCCHostedRegistrationFormVC.h
//  Pods
//
//  Created by Bambora On Mobile AB on 01/02/2016.
//
//

#import "BNEnums.h"
#import "BNPaymentBaseVC.h"
#import "BNPaymentWebview.h"

@import WebKit;

@class BNCCHostedFormParams;
@class BNAuthorizedCreditCard;
@class BNCCHostedRegistrationFormVC;

/**
 *  `BNCCHostedRegistrationFormVC` is a view controller that displays a webview containing a credit card registration form.
 */
@interface BNCCHostedRegistrationFormVC : BNPaymentBaseVC

/**
 *  BNPaymentWebviewDelegate delegate.
 */
@property(nonatomic, weak) id <BNPaymentWebviewDelegate> webviewDelegate;

/**
 *  An init method where you provide the params for the hosted form
 *
 *  @param params `BNCCHostedFormParams` used for requesting an URL for the hosted form
 *
 *  @return return an instance of `BNCCHostedRegistrationFormVC`
 */
- (instancetype)initWithHostedFormParams:(BNCCHostedFormParams *)params;

/**
 *  A method for setting the header view
 *
 *  @param headerView A `UIView` to be set as header
 */
- (void)addHeaderView:(UIView *)headerView;

/**
 *  A method for setting the footer view
 *
 *  @param footerView A `UIView` to be set as footer
 */
- (void)addFooterView:(UIView *)footerView;

@end
