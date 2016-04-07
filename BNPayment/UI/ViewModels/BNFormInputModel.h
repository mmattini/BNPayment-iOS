//
//  BNFormInputModel.h
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
