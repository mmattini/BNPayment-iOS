//
//  BNFormScrollView.h
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


#import <UIKit/UIKit.h>
#import "BNFormView.h"

@class BNFormModel;

/**
 *  `BNFormScrollView` is a custom scrollview used for displaying forms generated from a `BNFormModel`.
 */
@interface BNFormScrollView : UIScrollView <BNFormInputViewDelegate>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;

/**
 *  Set up the form from a `BNFormModel`
 *
 *  @param formModel `BNFormModel` for be used for generating the form
 */
- (void)setupWithModel:(BNFormModel *)formModel;

/**
 *  A method for handling keyboard will show notification.
 *  Call this on UIKeyboardWillShowNotification.
 *
 *  @param kbSize            Size of the keyboard.
 *  @param animationDuration Duration of the animation.
 *  @param animationCurve    The animation curve used.
 */
- (void)keyboardWillShowWithSize:(CGSize)kbSize
           andAnimationDuration:(CGFloat)animationDuration
               andAnimationCurve:(UIViewAnimationCurve)animationCurve;

/**
 *  A method for handling keyboard will hide notification.
 *  Call this on UIKeyboardWillHideNotification.
 *
 *  @param kbSize            Size of the keyboard.
 *  @param animationDuration Duration of the animation.
 *  @param animationCurve    The animation curve used.
 */
- (void)keyboardWillHideWithSize:(CGSize)kbSize
           andAnimationDuration:(CGFloat)animationDuration
               andAnimationCurve:(UIViewAnimationCurve)animationCurve;

@end
