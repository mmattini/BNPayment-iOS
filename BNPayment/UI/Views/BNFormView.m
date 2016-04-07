//
//  BNFormView.m
//  Pods
//
//  Created by Bambora On Mobile AB on 14/01/2016.
//
//

#import "BNFormView.h"
#import "BNFormInputModel.h"
#import "BNBundleUtils.h"

@implementation BNFormView {
    BNFormView *_childFormView;
}

- (instancetype)initWithModel:(BNFormInputModel *)model andFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitWithViewName:@"BNFormView" andBundle:[BNBundleUtils paymentLibBundle]];
        [self setupViewWithModel:model];
    }
    
    return self;
}

- (void)setupViewWithModel:(BNFormInputModel *)model {
    _childFormView = (BNFormView *)self.containerView;
    self.titleLabel = _childFormView.titleLabel;
    self.titleLabel.text = model.title;
    self.inputTextField = _childFormView.inputTextField;
    
    self.inputTextField.placeholder = model.placeholder ? model.placeholder : @"";
    [self.inputTextField addTarget:self action:@selector(inputDidBecomeFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
}

- (void)inputDidBecomeFirstResponder:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(formViewDidBecomeFirstResponder:)]) {
        [_delegate formViewDidBecomeFirstResponder:self];
    }
}

@end
