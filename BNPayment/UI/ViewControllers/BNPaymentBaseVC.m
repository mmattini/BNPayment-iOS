//
//  BNPaymentBaseVC.m
//  Pods
//
//  Created by Bambora On Mobile AB on 02/02/2016.
//
//

#import "BNPaymentBaseVC.h"

@interface BNPaymentBaseVC ()

@end

@implementation BNPaymentBaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onKeyboardWillHide:)
                                                name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onKeyboardWillShow:)
                                                name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onKeyboardDidHide:)
                                                name:UIKeyboardDidHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onKeyboardDidShow:)
                                                name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Methods for handling keyboard notifications

- (void)onKeyboardWillHide:(NSNotification *)notification {
    
}

- (void)onKeyboardDidHide:(NSNotification *)notification {
    
}

- (void)onKeyboardWillShow:(NSNotification *)notification {
    
}

- (void)onKeyboardDidShow:(NSNotification *)notification {
    
}

@end
