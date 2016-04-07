//
//  BNFormScrollView.h
//  Pods
//
//  Created by Bambora On Mobile AB on 14/01/2016.
//
//

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
