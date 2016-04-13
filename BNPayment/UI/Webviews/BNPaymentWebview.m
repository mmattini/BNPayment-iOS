//
//  BNPaymentWebview.m
//  Pods
//
//  Created by Bambora On Mobile AB on 11/02/2016.
//
//

#import "BNPaymentWebview.h"
#import "EPAYHostedFormStateChange.h"
#import "BNCreditCardEndpoint.h"
#import "BNCCHostedFormParams.h"
#import "BNAuthorizedCreditCard.h"

NSString * const BNCCRegistrationSubmissionDomain = @"com.bambora.error.creditcard.registration";

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

#pragma mark - Private methods

- (WKUserContentController *)createUserContentController {
    WKUserContentController *controller = [WKUserContentController new];
    [controller addScriptMessageHandler:self name:@"observe"];
    return controller;
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    NSError *error;
    EPAYHostedFormStateChange *stateChange = [[EPAYHostedFormStateChange alloc] initWithJSONDictionary:message.body
                                                                                                 error:&error];
    NSError *submissionError;
    
    if([self hasValidDelegate]) {
        switch ([stateChange status]) {
            case EPAYSubmissionStarted:
                [self.delegate BNPaymentWebview:self didStartOperation:BNPWVOperationSubmitCCData];
                break;
            case EPAYSuccess:
                [self registerAuthorizedCard:[stateChange generateAuthorizedCard]];
                [self.delegate BNPaymentWebview:self didFinishOperation:BNPWVOperationSubmitCCData];
                [self.delegate BNPaymentWebview:self didRegisterAuthorizedCard:[stateChange generateAuthorizedCard]];
                break;
            case EPAYSubmissionDeclined:
                submissionError = [NSError errorWithDomain:BNCCRegistrationSubmissionDomain code:EPAYSubmissionDeclined userInfo:nil];
                [self.delegate BNPaymentWebview:self didFailOperation:BNPWVOperationSubmitCCData withError:submissionError];
                break;
            case EPAYSystemError:
                submissionError = [NSError errorWithDomain:BNCCRegistrationSubmissionDomain code:EPAYSystemError userInfo:nil];
                [self.delegate BNPaymentWebview:self didFailOperation:BNPWVOperationSubmitCCData withError:submissionError];
                break;
            default:
                submissionError = [NSError errorWithDomain:BNCCRegistrationSubmissionDomain code:EPAYUnknown userInfo:nil];
                [self.delegate BNPaymentWebview:self didFailOperation:BNPWVOperationSubmitCCData withError:submissionError];
                break;
        }
    }
}

- (void)registerAuthorizedCard:(BNAuthorizedCreditCard *)authorizedCard {
    if (authorizedCard) {
        [[BNPaymentHandler sharedInstance] saveAuthorizedCreditCard:authorizedCard];
    }
}

- (BOOL)hasValidDelegate {
    BOOL isValid = NO;
    
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(BNPaymentWebview:didFinishOperation:)] &&
       [self.delegate respondsToSelector:@selector(BNPaymentWebview:didStartOperation:)] &&
       [self.delegate respondsToSelector:@selector(BNPaymentWebview:didFailOperation:withError:)]) {
        isValid = YES;
    }
    
    return isValid;
}

#pragma mark - Public methods

- (void)loadPaymentWebviewWithParams:(BNCCHostedFormParams *)params {
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(BNPaymentWebview:didStartOperation:)]) {
        [self.delegate BNPaymentWebview:self didStartOperation:BNPWVOperationFetchURL];
    }
    
    [BNCreditCardEndpoint initiateCreditCardRegistrationForm:params completion:^(NSString *url, NSError *error) {
        if(url) {
            if(self.delegate &&
               [self.delegate respondsToSelector:@selector(BNPaymentWebview:didFinishOperation:)]) {
            }
            
            NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
            [self loadRequest:urlRequest];
        }else {
            if(self.delegate &&
               [self.delegate respondsToSelector:@selector(BNPaymentWebview:didFailOperation:withError:)]) {
                [self.delegate BNPaymentWebview:self didFailOperation:BNPWVOperationFetchURL withError:error];
            }
        }
    }];
}

#pragma mark - WKNavigationDelegate methods

- (void)webView:(WKWebView *)webView
didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(BNPaymentWebview:didStartOperation:)]) {
        [self.delegate BNPaymentWebview:self didStartOperation:BNPWVOperationLoadURL];
    }
}

- (void)webView:(WKWebView *)webView
didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation
      withError:(NSError *)error {
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(BNPaymentWebview:didFailOperation:withError:)]) {
        [self.delegate BNPaymentWebview:self didFailOperation:BNPWVOperationLoadURL withError:error];
    }
}

- (void)webView:(WKWebView *)webView
didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(BNPaymentWebview:didFinishOperation:)]) {
        [self.delegate BNPaymentWebview:self didFinishOperation:BNPWVOperationLoadURL];
    }
}

- (void)webView:(WKWebView *)webView
didFailNavigation:(null_unspecified WKNavigation *)navigation
      withError:(NSError *)error {
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(BNPaymentWebview:didFailOperation:withError:)]) {
        if(self.delegate &&
           [self.delegate respondsToSelector:@selector(BNPaymentWebview:didFailOperation:withError:)]) {
            [self.delegate BNPaymentWebview:self didFailOperation:BNPWVOperationLoadURL withError:error];
        }
    }
}

@end
