//
//  BNCCRegistrationFormVC.m
//  Pods
//
//  Created by Bambora On Mobile AB on 12/01/2016.
//
//

#import "BNCCRegistrationFormVC.h"
#import "UIImage+BNUtils.h"
#import "UIView+BNUtils.h"
#import "BNFormScrollView.h"
#import "BNCCFormInputModel.h"
#import "BNFormModel.h"
#import "BNCreditCard.h"
#import "BNPaymentHandler.h"
#import "BNBundleUtils.h"
#import "BNAuthorizedCreditCard.h"

@interface BNCCRegistrationFormVC ()

@property (nonatomic, strong) IBOutlet BNFormScrollView *scrollView;
@property (nonatomic, strong) BNCCFormInputModel *aliasInputModel;
@property (nonatomic, strong) BNCCFormInputModel *ccInputModel;
@property (nonatomic, strong) BNCCFormInputModel *expireInputModel;
@property (nonatomic, strong) BNCCFormInputModel *cvvInputModel;
@property (nonatomic, strong) BNFormModel *formModel;

@end

@implementation BNCCRegistrationFormVC

- (instancetype)init {
    return [super initWithNibName:@"BNCCRegistrationFormVC" bundle:[BNBundleUtils paymentLibBundle]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupForm];
}

#pragma mark - Setup methods

- (void)setupForm {
    // Setup alias form input model
    self.aliasInputModel = [BNCCFormInputModel new];
    self.aliasInputModel.iconImage = [UIImage loadImageWithName:@"iconCard"
                                                 fromBundle:[BNBundleUtils paymentLibBundle]];
    self.aliasInputModel.title = @"Alias";
    self.aliasInputModel.mappingKey = @"alias";
    self.aliasInputModel.placeholder = @"Alias";
    
    // Setup CC number form input model
    self.ccInputModel = [BNCCFormInputModel new];
    self.ccInputModel.iconImage = [UIImage loadImageWithName:@"iconCard"
                                              fromBundle:[BNBundleUtils paymentLibBundle]];
    self.ccInputModel.title = @"Card";
    self.ccInputModel.mappingKey = @"card_number";
    self.ccInputModel.placeholder = @"Card number";

    // Setup expirt date form input model
    self.expireInputModel = [BNCCFormInputModel new];
    self.expireInputModel.iconImage = [UIImage loadImageWithName:@"iconCalendar"
                                                  fromBundle:[BNBundleUtils paymentLibBundle]];
    self.expireInputModel.title = @"Expires";
    self.expireInputModel.mappingKey = @"expiry_date";
    self.expireInputModel.placeholder = @"MM/YY";

    // Setup CC form input model
    self.cvvInputModel = [BNCCFormInputModel new];
    self.cvvInputModel.iconImage = [UIImage loadImageWithName:@"iconLock"
                                               fromBundle:[BNBundleUtils paymentLibBundle]];
    self.cvvInputModel.title = @"CVV";
    self.cvvInputModel.mappingKey = @"cvv";
    self.cvvInputModel.placeholder = @"3 or 4 number cvv";

    // Setup submit button;
    UIButton* submitButton = [[UIButton alloc] initWithFrame:CGRectMake(8, 0, CGRectGetWidth(self.view.frame)-16, 50)];
    submitButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [submitButton setBackgroundColor:[UIColor colorWithRed:110/255.f green:83/255.f blue:147/255.f alpha:1.f]];
    [submitButton setCornerRadius:25];
    [submitButton setTitle:@"Save card" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.formModel = [BNFormModel new];
    self.formModel.models = @[_aliasInputModel, _ccInputModel, _expireInputModel, _cvvInputModel];
    self.formModel.submitButton = submitButton;
    
    [self.scrollView setupWithModel:self.formModel];
}

- (void)updateFormModelWithCardInfo:(BNCreditCard *)creditCard {
    [self.ccInputModel updateValue:creditCard.cardNumber];
    [self.expireInputModel updateValue:[NSString stringWithFormat:@"%@/%@", creditCard.expMonth, creditCard.expYear]];
    [self.cvvInputModel updateValue:creditCard.cvv];
}

- (void)updateExpiryDateField:(UIDatePicker *)sender {
    // Implement later
}

#pragma mark - Handle keyboard events

- (void)onKeyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo) {
        CGSize kbSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGFloat animationDuration = [userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
        UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
        
        [_scrollView keyboardWillHideWithSize:kbSize
                         andAnimationDuration:animationDuration
                            andAnimationCurve:animationCurve];
    }
    
}

- (void)onKeyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo) {
        CGSize kbSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGFloat animationDuration = [userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
        UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
        
        [_scrollView keyboardWillShowWithSize:kbSize
                         andAnimationDuration:animationDuration
                            andAnimationCurve:animationCurve];
    }

}

- (void)submitAction:(id)sender {
    NSDictionary *formDict = [_formModel generateFormDictionary];
    NSError *error;
    BNCreditCard *creditCard = [[BNCreditCard alloc] initWithJSONDictionary:formDict error:&error];
    NSLog(@"Credit card with number: %@ created", creditCard.cardNumber);
    _completionBlock(BNCCRegCompletionDone, nil);
}

@end
