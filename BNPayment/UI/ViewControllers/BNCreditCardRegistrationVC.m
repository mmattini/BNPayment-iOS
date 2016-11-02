//
//  BNCreditCardRegistrationVC.m
//  Copyright (c) 2016 Bambora ( http://bambora.com/ )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "BNCreditCardRegistrationVC.h"
#import "BNBaseTextField.h"
#import "BNCreditCardNumberTextField.h"
#import "BNCreditCardExpiryTextField.h"
#import "UIView+BNUtils.h"
#import "UIColor+BNColors.h"
#import "UITextField+BNCreditCard.h"
#import "BNLoaderButton.h"

NSInteger const TextFieldHeight = 50;
NSInteger const ButtonHeight = 50;
NSInteger const Padding = 15;
NSInteger const TitleHeight = 30;

@interface BNCreditCardRegistrationVC ()

@property (nonatomic, strong) UIScrollView *formScrollView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) BNCreditCardNumberTextField *cardNumberTextField;
@property (nonatomic, strong) BNCreditCardExpiryTextField *cardExpiryTextField;
@property (nonatomic, strong) BNBaseTextField *cardCVCTextField;

@property (nonatomic, strong) BNLoaderButton *submitButton;

@end

@implementation BNCreditCardRegistrationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupCreditCardForm];
    [self.cardNumberTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutCreditCardForm];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [UIView setAnimationsEnabled:NO];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [UIView setAnimationsEnabled:YES];
        [self layoutCreditCardForm];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

}

- (void)layoutCreditCardForm {
    CGRect viewRect = self.view.bounds;
    
    self.formScrollView.frame = viewRect;
    
    self.titleLabel.frame = CGRectMake(Padding,
                                       Padding*2,
                                       CGRectGetWidth(viewRect)-2*Padding,
                                       TitleHeight);
    
    NSInteger inputWidth = floorf(CGRectGetWidth(viewRect)-2*Padding);
    inputWidth -= inputWidth % 2;
    
    self.cardNumberTextField.frame = CGRectMake(Padding,
                                                CGRectGetMaxY(self.titleLabel.frame),
                                                inputWidth,
                                                TextFieldHeight);
    
    self.cardExpiryTextField.frame = CGRectMake(Padding,
                                                CGRectGetMaxY(self.cardNumberTextField.frame)-1,
                                                ceilf((inputWidth)/2.f),
                                                TextFieldHeight);
    
    self.cardCVCTextField.frame = CGRectMake(CGRectGetMaxX(self.cardExpiryTextField.frame)-1,
                                                CGRectGetMaxY(self.cardNumberTextField.frame)-1,
                                                ceilf((inputWidth)/2.f)+1,
                                                TextFieldHeight);
    
    self.submitButton.frame = CGRectMake(0,
                                         CGRectGetHeight(self.formScrollView.frame)-ButtonHeight,
                                         CGRectGetWidth(viewRect),
                                         ButtonHeight);
}

- (void)setupCreditCardForm {
    self.formScrollView = [UIScrollView new];
    self.formScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.formScrollView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = NSLocalizedString(@"ENTER CARD DETAILS", @"Card details");
    self.titleLabel.textColor = [UIColor BNTextColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12.f weight:UIFontWeightMedium];
    [self.formScrollView addSubview:self.titleLabel];
    
    self.cardNumberTextField = [[BNCreditCardNumberTextField alloc] init];
    self.cardNumberTextField.placeholder = NSLocalizedString(@"5555 5555 5555 5555", @"Placeholder");
    [self.cardNumberTextField applyStyle];
    [self.cardNumberTextField addTarget:self action:@selector(validateFields) forControlEvents:UIControlEventEditingChanged];
    [self.formScrollView addSubview:self.cardNumberTextField];
    
    self.cardExpiryTextField = [[BNCreditCardExpiryTextField alloc] init];
    self.cardExpiryTextField.placeholder = NSLocalizedString(@"MM/YY", @"Placeholder");
    [self.cardExpiryTextField applyStyle];
    [self.cardExpiryTextField addTarget:self action:@selector(validateFields) forControlEvents:UIControlEventEditingChanged];
    [self.formScrollView addSubview:self.cardExpiryTextField];
    
    self.cardCVCTextField = [[BNBaseTextField alloc] init];
    self.cardCVCTextField.placeholder = NSLocalizedString(@"000(0)", @"Placeholder");
    self.cardCVCTextField.inputRegex = @"^[0-9]{0,4}$";
    self.cardCVCTextField.validRegex = @"^[0-9]{3,4}$";
    [self.cardCVCTextField applyStyle];
    [self.cardCVCTextField addTarget:self action:@selector(validateFields) forControlEvents:UIControlEventEditingChanged];
    [self.formScrollView addSubview:self.cardCVCTextField];
    
    self.submitButton = [BNLoaderButton new];
    [self.submitButton setBackgroundColor:[UIColor BNPurpleColor]];
    [self.submitButton setTitle:NSLocalizedString(@"Save card", @"") forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitButton addTarget:self
                          action:@selector(submitCreditCardInformation:)
                forControlEvents:UIControlEventTouchUpInside];
    self.submitButton.enabled = NO;
    self.submitButton.alpha = .5f;
    [self.formScrollView addSubview:self.submitButton];

}

- (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message {

    NSString *closeTitle = NSLocalizedString(@"bnpayment.ui.popup.okclose", nil);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message
                                                       delegate:nil
                                              cancelButtonTitle:closeTitle otherButtonTitles:nil];
    [alertView show];
}

- (void)submitCreditCardInformation:(UIButton *)sender {
 
    BNCreditCard *creditCard = [BNCreditCard new];
    creditCard.cardNumber = [self.cardNumberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    creditCard.expMonth = [self.cardExpiryTextField getExpiryMonth];
    creditCard.expYear = [self.cardExpiryTextField getExpiryYear];
    creditCard.cvv = self.cardCVCTextField.text;
    
    BNRegisterCCParams *params = [[BNRegisterCCParams alloc] initWithCreditCard:creditCard];
    
    [self.submitButton setLoading:YES];
    
    [[BNPaymentHandler sharedInstance] registerCreditCard:params completion:^(BNAuthorizedCreditCard *card, NSError *error) {
        if(self.completionBlock && card) {
            self.completionBlock(BNCCRegCompletionDone, card);
        }
        else {
            NSString *title = NSLocalizedString(@"bnpayment.error.submitcardinfo.title", nil);
            NSString *message = NSLocalizedString(@"bnpayment.error.submitcardinfo.message", nil);
            [self showAlertViewWithTitle:title message:message];
        }
        [self.submitButton setLoading:NO];
    }];
}

#pragma mark - Handle keyboard events

- (void)onKeyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo) {
        CGSize kbSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGFloat animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [self animateKeyboardVisible:NO kbSize:kbSize duration:animationDuration];
    }
    
}

- (void)onKeyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo) {
        CGSize kbSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGFloat animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [self animateKeyboardVisible:YES kbSize:kbSize duration:animationDuration];
    }
}

- (void)animateKeyboardVisible:(BOOL)visible kbSize:(CGSize)kbSize duration:(CGFloat)duration {
    
    CGFloat height = visible ? CGRectGetHeight(self.view.frame)-kbSize.height : CGRectGetHeight(self.view.frame);

    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.submitButton setYoffset:MAX(height-ButtonHeight, CGRectGetMaxY(self.cardCVCTextField.frame)+Padding)];
        [self.formScrollView setHeight:height];
    } completion:^(BOOL finished) {
        [self.formScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(self.submitButton.frame))];
    }];
}

- (void)validateFields {
    BOOL validCardNumber = [self.cardNumberTextField validCardNumber];
    BOOL validExpiry = [self.cardExpiryTextField validExpiryDate];
    BOOL validCVC = [self.cardCVCTextField validCVC];
    
    if(validCardNumber && validExpiry && validCVC) {
        self.submitButton.enabled = YES;
        self.submitButton.alpha = 1.f;
    }else {
        self.submitButton.enabled = NO;
        self.submitButton.alpha = 0.5f;
    }
}

@end
