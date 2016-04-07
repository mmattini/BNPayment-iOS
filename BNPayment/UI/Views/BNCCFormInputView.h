//
//  BNCCFormInputView.h
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

@class BNCCFormInputModel;
@class BNCCFormInputView;

typedef enum : NSUInteger {
    BNFormInputTypeCCNumber,
    BNFormInputTypeExpiryDate,
    BNFormInputTypeCVV,
    BNFormInputTypeAlias
} BNFormInputType;


@protocol BNCCFormInputViewDelegate <NSObject>

- (void)formInputBecameFirstResponder:(BNCCFormInputView *)formInputView;

@end

@interface BNCCFormInputView : BNFormView

/**
 *  An init method which takes a `BNCCFormInputModel` as extra param.
 *
 *  @param model `BNCCFormInputModel` used to generate the view.
 *  @param frame `CGRect` of the view.
 *
 *  @return An instance of `BNCCFormInputView`.
 */
- (instancetype)initWithModel:(BNCCFormInputModel *)model andFrame:(CGRect)frame;

@property (nonatomic, assign) BNFormInputType inputType;

@end
