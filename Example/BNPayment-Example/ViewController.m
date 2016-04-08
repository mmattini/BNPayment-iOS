//
//  BNViewController.m
//  BNPayment
//
//  Created by Bambora On Mobile AB on 11/12/2015.
//  Copyright (c) 2015 Bambora On Mobile AB. All rights reserved.
//

#import "ViewController.h"
#import <BNPayment/BNPayment.h>

@interface ViewController ()

@end

@implementation ViewController

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
    
    __weak ViewController *weakSelf = self;
    
    BNCCHostedRegistrationFormVC *ccRegistrationVC = [[BNCCHostedRegistrationFormVC alloc] initWithHostedFormParams:[BNCCHostedFormParams mockObject]];
    ccRegistrationVC.completionBlock = ^(BNCCRegCompletion completion, BNAuthorizedCreditCard *card){
        [weakSelf.navigationController popViewControllerAnimated:YES];
        [weakSelf displaAliasAlertWithAuthorizedCard:card];
    };
    
    [self.navigationController pushViewController:ccRegistrationVC animated:YES];
}

-(IBAction)unregisterCreditCard:(id)sender {
    NSArray *authorizedCards = [[BNPaymentHandler sharedInstance] authorizedCards];
    
    if(authorizedCards.count > 0) {
        
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
        
    }else {
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
        
    }else {
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
                                                      result:^(BNPaymentResult result) {
                                                          BOOL success = result == BNPaymentSuccess;
                                                          NSString *title = success ? @"Success" : @"Failure";
                                                          NSString *message = success ?
                                                          [NSString stringWithFormat:@"The payment succeeded."]:
                                                          [NSString stringWithFormat:@"The payment did not succeed."];
                                                          
                                                          UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
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
    
    if(card) {
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

    for(UIAlertAction *action in actions) {
        [alert addAction:action];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self presentViewController:alert animated:YES completion:nil];
    });
}

@end
