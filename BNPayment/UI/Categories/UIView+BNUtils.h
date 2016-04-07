//
//  UIView+BNUtils.h
//  Pods
//
//  Created by Oskar Henriksson on 13/01/2016.
//
//

#import <UIKit/UIKit.h>

@interface UIView (BNUtils)

/**
 *  A method for changing origin y of an `UIView`.
 *
 *  @param yOffset New y origin of the view
 */
- (void)setYoffset:(NSInteger)yOffset;

/**
 *  A method for changing origin x of an `UIView`.
 *
 *  @param xOffset New x origin of the view
 */
- (void)setXoffset:(NSInteger)xOffset;

/**
 *  A method for setting height of an `UIView`.
 *
 *  @param height New height of the view
 */
- (void)setHeight:(NSInteger)height;

/**
 *  A method for setting width of an `UIView`.
 *
 *  @param width New width of the view.
 */
- (void)setWidth:(NSInteger)width;

/**
 *  A method for setting a corner radius of an `UIView`
 *
 *  @param cornerRadius New corner radius of the view.
 */
- (void)setCornerRadius:(NSInteger)cornerRadius;

@end
