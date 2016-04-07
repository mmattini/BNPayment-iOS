//
//  BNViewController.m
//  Copyright © 2016 Bambora. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ViewController.h"
#import <BNPayment/BNPayment.h>

@interface ViewController () <BNPaymentWebviewDelegate>

@end

@implementation ViewController {
    BNCCHostedRegistrationFormVC *ccHostedRegistrationVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)registerCreditCard:(id)sender {
 
    BNCCRegistrationFormVC *ccRegistrationVC = [BNCCRegistrationFormVC new];
    ccRegistrationVC.completionBlock = ^(BNCCRegCompletion completion, BNAuthorizedCreditCard *card){
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:ccRegistrationVC animated:YES];
}

-(IBAction)registerCreditCardHostedForm:(id)sender {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    
    ccHostedRegistrationVC = [[BNCCHostedRegistrationFormVC alloc] initWithHostedFormParams:[BNCCHostedFormParams mockObject]];
    ccHostedRegistrationVC.webviewDelegate = self;
    [ccHostedRegistrationVC addHeaderView:headerView];
    
    [self.navigationController pushViewController:ccHostedRegistrationVC animated:YES];
}

-(IBAction)unregisterCreditCard:(id)sender {
    NSArray *authorizedCards = [[BNPaymentHandler sharedInstance] authorizedCards];
    
    if (authorizedCards.count > 0) {
        
        NSMutableArray *actions = [[NSMutableArray alloc] initWithCapacity:authorizedCards.count+1];
        
        
        [authorizedCards enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            __weak BNAuthorizedCreditCard *cc = obj;
            NSString *actionTitle = cc.creditCardAlias ? cc.creditCardAlias : cc.creditCardNumber;

            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               [[BNPaymentHandler sharedInstance] removeAuthorizedCreditCard:cc];
                                                           }];
            [actions addObject:action];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                             handler:nil];
        [actions addObject:cancelAction];
        
        [self displayAlertControllerWithStyle:UIAlertControllerStyleActionSheet
                                        title:@"Choose credit card"
                                      message:nil
                                       action:actions];
        
    } else {
        UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:nil];
        [self displayAlertControllerWithStyle:UIAlertControllerStyleAlert
                                        title:@"No credit card registered"
                                      message:@"There is nothing to remove."
                                       action:@[confirmAction]];
    }
}

-(IBAction)makePurchase:(id)sender {
    NSArray *authorizedCards = [[BNPaymentHandler sharedInstance] authorizedCards];
    
    if(authorizedCards.count > 0) {
        
        NSMutableArray *actions = [[NSMutableArray alloc] initWithCapacity:authorizedCards.count+1];
        
        [authorizedCards enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            __weak BNAuthorizedCreditCard *cc = obj;
            NSString *actionTitle = cc.creditCardAlias ? cc.creditCardAlias : cc.creditCardNumber;
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               [self makePaymentWithCard:cc];
                                                           }];
            [actions addObject:action];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel
                                                              handler:nil];
        [actions addObject:cancelAction];
        
        [self displayAlertControllerWithStyle:UIAlertControllerStyleActionSheet
                                        title:@"Choose credit card"
                                      message:nil
                                       action:actions];
        
    } else {
        UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                              handler:nil];
        [self displayAlertControllerWithStyle:UIAlertControllerStyleAlert
                                        title:@"No credit card registered"
                                      message:@"Please register a credit card in order to make a purchase."
                                       action:@[confirmAction]];
    }
}

- (void)makePaymentWithCard:(BNAuthorizedCreditCard *)card {
    BNPaymentParams *params = [BNPaymentParams mockObject];
    params.token = card.creditCardToken;
    
    [[BNPaymentHandler sharedInstance] makePaymentWithParams:params
                                                      result:^(BNPaymentResult result, NSError *error) {
                                                          BOOL success = result == BNPaymentSuccess;
                                                          NSString *title = success ? @"Success" : @"Failure";
                                                          NSString *message = success ?
                                                          [NSString stringWithFormat:@"The payment succeeded."]:
                                                          [NSString stringWithFormat:@"The payment did not succeed."];
                                                          
                                                          UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                                  style:UIAlertActionStyleDefault
                                                                                                                handler:nil];
                                                          
                                                          [self displayAlertControllerWithStyle:UIAlertControllerStyleAlert
                                                                                          title:title
                                                                                        message:message
                                                                                         action:@[confirmAction]];
                                                      }];
}


- (void)displaAliasAlertWithAuthorizedCard:(BNAuthorizedCreditCard *) __weak card {
    NSString *title = card ? @"Name" : @"No card";
    NSString *message = card ? @"Please name the credit card." : @"No credit card was registered!";
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(card) {
            UITextField *aliasTextField = alertController.textFields.firstObject;
            card.creditCardAlias = aliasTextField.text.length > 0 ? aliasTextField.text : card.creditCardNumber;
            [[BNPaymentHandler sharedInstance] saveAuthorizedCreditCard:card];
        }
    }];
    
    if (card) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"Name";
        }];
    }
    
    [alertController addAction:action];
    
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

- (void)displayAlertControllerWithStyle:(UIAlertControllerStyle)style
                                  title:(NSString *)title
                                message:(NSString *)message
                                 action:(NSArray *)actions {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:style];

    for (UIAlertAction *action in actions) {
        [alert addAction:action];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self presentViewController:alert animated:YES completion:nil];
    });
}

#pragma mark - BNPaymentWebviewDelegate methods

- (void)BNPaymentWebview:(BNPaymentWebview *)webview didRegisterAuthorizedCard:(BNAuthorizedCreditCard *)authorizedCard {
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.navigationController popViewControllerAnimated:YES];
        [self displaAliasAlertWithAuthorizedCard:authorizedCard];
    });
}

- (void)BNPaymentWebview:(BNPaymentWebview *)webview didStartOperation:(BNPaymentWebviewOperation)operation {
    if(operation == BNPWVOperationSubmitCCData) {
        [ccHostedRegistrationVC setWebViewLoading:YES];
    }
}

- (void)BNPaymentWebview:(BNPaymentWebview *)webview didFinishOperation:(BNPaymentWebviewOperation)operation {
    if(operation == BNPWVOperationSubmitCCData) {
        [ccHostedRegistrationVC setWebViewLoading:NO];
    }
}

- (void)BNPaymentWebview:(BNPaymentWebview *)webview didFailOperation:(BNPaymentWebviewOperation)operation withError:(NSError *)error {
    
    if (error.code == EPAYSubmissionDeclined) {
        [ccHostedRegistrationVC setWebViewLoading:NO];
        return;
    }
    
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Ok"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                                dispatch_async(dispatch_get_main_queue(), ^(){
                                                                    [ccHostedRegistrationVC setWebViewLoading:NO];
                                                                    [self.navigationController popViewControllerAnimated:YES];
                                                                });
                                                            }];

    [self displayAlertControllerWithStyle:UIAlertControllerStyleAlert title:@"Error" message:@"Error" action:@[confirmAction]];
}

@end
