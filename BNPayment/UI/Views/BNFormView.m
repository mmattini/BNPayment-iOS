//
//  BNFormView.m
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
