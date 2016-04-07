//
//  BNFormInputModel.m
//  Pods
//
//  Created by Bambora On Mobile AB on 14/01/2016.
//
//

#import "BNFormInputModel.h"
#import "BNFormView.h"

@interface BNFormInputModel()

@property(nonatomic, strong) BNFormView *formView;

@end

@implementation BNFormInputModel

- (UIView *)generateInputViewWithFrame:(CGRect)frame {
    self.formView = [[BNFormView alloc] initWithModel:self andFrame:frame];
    [self setupInputView];
    return self.formView;
}

- (void)setupInputView {
    if (self.formView) {
        [self.formView.inputTextField addTarget:self
                                         action:@selector(valueChanged:)
                               forControlEvents:UIControlEventEditingChanged];
    }
}

- (void)valueChanged:(UITextField *)textField {
    self.value = textField.text;
}

- (void)updateValue:(NSString *)value {
    self.value = value;
    
    if (self.formView.inputTextField && value) {
        self.formView.inputTextField.text = value;
    }
}

@end
