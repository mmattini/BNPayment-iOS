//
//  BNCCHostedRegistrationFormVC.m
//  Pods
//
//  Created by Bambora On Mobile AB on 01/02/2016.
//
//

#import "BNBundleUtils.h"
#import "BNCCFormInputGroup.h"
#import "BNCCHostedFormParams.h"
#import "EPAYHostedFormStateChange.h"
#import "BNCCHostedRegistrationFormVC.h"
#import "BNPaymentHandler.h"
#import "BNPaymentWebview.h"
#import "UIView+BNUtils.h"
#import "BNAuthorizedCreditCard.h"
#import "BNHostedRegistrationFormFooter.h"

@interface BNCCHostedRegistrationFormVC  () <BNPaymentWebviewDelegate, WKNavigationDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *contentView;
@property (nonatomic, strong) IBOutlet UIView *headerContainerView;
@property (nonatomic, strong) IBOutlet UIView *webviewContainerView;
@property (nonatomic, strong) IBOutlet UIView *footerContainerView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headerHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *webviewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *footerHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomMargin;

@property (strong, nonatomic) NSURLSessionDataTask *webviewURLDataTask;

@property (nonatomic, assign) CGFloat headerViewHeight;
@property (nonatomic, assign) CGFloat footerViewHeight;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) BNPaymentWebview *webView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) BNCCHostedFormParams *requestParams;

@property (nonatomic, assign) BOOL keyboardShowing;
@property (nonatomic, assign) BOOL isCardRegistered;

@end

@implementation BNCCHostedRegistrationFormVC

static int kObservingContentSizeChangesContext;
static float AnimationDuration = 0.2f;

- (instancetype)initWithHostedFormParams:(BNCCHostedFormParams *)params {
    self = [super initWithNibName:@"BNCCHostedRegistrationFormVC" bundle:[BNBundleUtils paymentLibBundle]];
    
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.requestParams = params;
    }
    
    return self;
}

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupHeaderAndFooterView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupWebview];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.webviewURLDataTask cancel];
    self.webView.scrollView.delegate = nil;
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize" context:&kObservingContentSizeChangesContext];
    
    if (!_isCardRegistered && self.completionBlock) {
        self.completionBlock(BNCCRegCompletionCancelled, nil);
    }
}

- (void)setupHeaderAndFooterView {
    if (self.headerView) {
        [self.headerView setWidth:CGRectGetWidth(self.headerContainerView.frame)];
        [self.headerContainerView addSubview:self.headerView];
        self.headerViewHeight = CGRectGetHeight(self.headerView.frame);
        self.headerHeight.constant = self.headerViewHeight;
    }

    if (self.footerView) {
        [self.footerView setWidth:CGRectGetWidth(self.footerContainerView.frame)];
        [self.footerContainerView addSubview:self.footerView];
        self.footerViewHeight = CGRectGetHeight(self.footerView.frame);
        self.footerHeight.constant = self.footerViewHeight;
    }
}

#pragma mark - Public methods

- (void)addHeaderView:(UIView *)headerView {
    self.headerView = headerView;
    self.headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (void)addFooterView:(UIView *)footerView {
    self.footerView = footerView;
    self.footerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == &kObservingContentSizeChangesContext) {
        CGSize contentSize = ((UIScrollView *)object).contentSize;
        if (contentSize.height != self.webviewHeight.constant && contentSize.width == self.webView.frame.size.width) {
            [self animateWebviewContentWithContentSize:contentSize];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Handle keyboard

- (void)onKeyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    self.keyboardShowing = YES;

    if (userInfo) {
        CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGFloat animationDuration = [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [self animateContentViewBottomMargin:kbSize.height duration:animationDuration];
    }
}

- (void)onKeyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    self.keyboardShowing = NO;
    
    if (userInfo) {
        CGFloat animationDuration = [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

        // Ugly fix for avoiding doing an extra animation when the webview changes input
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            [self animateContentViewBottomMargin:0 duration:animationDuration];
        });
    }
}

#pragma mark - Animation methods

- (void)animateContentViewBottomMargin:(CGFloat)bottomMagin duration:(CGFloat)duration {
 
    // Prevent unecessary animation
    if ((self.keyboardShowing && bottomMagin == 0) || (bottomMagin == self.contentViewBottomMargin.constant)) {
        return;
    }

    self.headerHeight.constant = [self calculateHeaderHeight:bottomMagin];
    self.contentViewBottomMargin.constant = bottomMagin;
    
    [UIView animateWithDuration:duration delay:0  options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

- (void)animateWebviewContentWithContentSize:(CGSize)contentSize {
    [UIView animateWithDuration:AnimationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.webviewHeight.constant = contentSize.height;
        [self.webView setHeight:contentSize.height];
        self.webviewContainerView.clipsToBounds = YES;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished){
        self.webviewContainerView.clipsToBounds = NO;

        [UIView animateWithDuration:AnimationDuration delay:AnimationDuration options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self setWebViewLoading:self.webView.loading];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (CGFloat)calculateHeaderHeight:(CGFloat) bottomMargin {
    if (bottomMargin > 0) {
        CGFloat contentViewContentOffset = self.contentView.contentOffset.y;
        return self.headerViewHeight - MAX(0, self.headerViewHeight-contentViewContentOffset);
    }
    
    return self.headerViewHeight;
}

#pragma mark - Handling webview

- (void)setupWebview {
    self.webView = [[BNPaymentWebview alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), self.webviewHeight.constant)];
    self.webView.navigationDelegate = self;
    self.webView.delegate = self;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.clipsToBounds = NO;
    
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:&kObservingContentSizeChangesContext];
    [self addBNWebview];
}

- (void)addBNWebview {
    [self.webviewContainerView addSubview:self.webView];
    [self.webviewContainerView bringSubviewToFront:self.activityIndicator];
    [self loadWebview];
}

- (void)loadWebview {
    if (!self.webviewURLDataTask) {
        [self setWebViewLoading:YES];
        self.webviewURLDataTask = [[BNPaymentHandler sharedInstance] initiateCreditCardRegistrationWithParams:self.requestParams
                                                                                                        completion:^(NSString *url) {
            [self setWebViewLoading:url != nil];
            NSURLRequest *urlRequest = [[NSURLRequest alloc]
                                        initWithURL:[NSURL URLWithString:url]];
            [self.webView loadRequest:urlRequest];
        }];
    }
}

- (void)setWebViewLoading:(BOOL)isLoading {
    CGFloat webviewAplha = isLoading ? 0 : 1.f;
    
    if (isLoading) {
        [self.activityIndicator startAnimating];
    }else {
        [self.activityIndicator stopAnimating];
    }
    
    self.activityIndicator.alpha = 1-webviewAplha;
    self.webView.alpha = webviewAplha;
}

#pragma mark - BNPaymentWebviewDelegate methods

- (void)webiew:(WKWebView *)webview didReceiveStateChange:(EPAYHostedFormStateChange *)stateChange {
    NSInteger statusCode = [stateChange status];
    
    BOOL shouldStartLoading = statusCode == EPAYSubmissionStarted;
    [self setWebViewLoading:shouldStartLoading];
    
    switch (statusCode) {
        case EPAYSuccess:
            [self handleSuccessfullCardRegistration:[stateChange generateAuthorizedCard]];
            break;
        default: // Do nothing here
            break;
    }
}

- (void)handleSuccessfullCardRegistration:(BNAuthorizedCreditCard *)authorizedCard {
    if (authorizedCard) {
        [[BNPaymentHandler sharedInstance] saveAuthorizedCreditCard:authorizedCard];
        _isCardRegistered = YES;
    }
    
    if (self.completionBlock) {
        self.completionBlock(BNCCRegCompletionDone, authorizedCard);
    }
}

#pragma mark - WKNavigationDelegate methods

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [self setWebViewLoading:YES];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self setWebViewLoading:NO];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self setWebViewLoading:NO];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self setWebViewLoading:NO];
}

@end
