//
//  BNCCFormInputView.h
//  Pods
//
//  Created by Bambora On Mobile AB on 12/01/2016.
//
//

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
