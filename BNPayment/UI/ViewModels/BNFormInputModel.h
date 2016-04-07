//
//  BNFormInputModel.h
//  Pods
//
//  Created by Bambora On Mobile AB on 14/01/2016.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BNFormView;

/**
 *  `BNFormInputModel` represents the basic form input.
 */
@interface BNFormInputModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *mappingKey;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) UIView *inputView;

/**
 *  A method for generating a view representation of the `BNFormInputModel`
 *
 *  @param frame The frame of the view to be generated.
 *
 *  @return A `UIView` representation of the `BNFormInputModel` instance.
 */
- (UIView *)generateInputViewWithFrame:(CGRect)frame;

/**
 *  A setup method for the input view
 */
- (void)setupInputView;

/**
 *  Update the value of the form model.
 *
 *  @param value The new value of the form model.
 */
- (void)updateValue:(NSString *)value;

@end
