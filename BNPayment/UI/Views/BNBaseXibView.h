//
//  BaseXibView.h
//  Pods
//
//  Created by Bambora On Mobile AB on 12/01/2016.
//
//

#import <UIKit/UIKit.h>

/**
 *  A view wrapper object to help you use a .xib file for a `UIView`.
 */
@interface BNBaseXIBView : UIView

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *customConstraints;

/**
 *  A method for initializing a view with a .xib.
 *
 *  @param viewName `NSString` representing the name of the view.
 *  @param bundle   `NSBundle` containing the view.
 */
- (void)commonInitWithViewName:(NSString *)viewName andBundle:(NSBundle *)bundle;

@end