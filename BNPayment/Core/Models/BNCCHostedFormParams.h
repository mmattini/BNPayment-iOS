//
//  BNCCHostedFormParams.h
//  Pods
//
//  Created by Bambora On Mobile AB on 05/02/2016.
//
//

#import <BNBase/BNBaseModel.h>

@class BNCCFormInputGroup;

/**
 *  `BNCCHostedFormParams` is used for generating params to /hpp/ endpoint
 */
@interface BNCCHostedFormParams : BNBaseModel

@property (nonatomic, strong) NSString *cssURL;
@property (nonatomic, strong) NSString *platform;
@property (nonatomic, strong) NSArray<BNCCFormInputGroup *> *inputGroups;
@property (nonatomic, strong) NSString *submitButtonText;

/**
 *  This method is used for setting the placeholder text for the credit card number input field in the hosted page.
 *  This will be translated into setting the HTML placeholder attribute.
 *
 *  @param placeholder `NSString` representing the placeholder text.
 */
- (void)CCNumberPlaceholder:(NSString *)placeholder;

/**
 *  This method is used for setting the placeholder text for the expiry date input field in the hosted page.
 *  This will be translated into setting the HTML placeholder attribute.
 *
 *  @param placeholder `NSString` representing the placeholder text.
 */
- (void)expiryPlaceholder:(NSString *)placeholder;

/**
 *  This method is used for setting the placeholder text for the CVV/CVC input field in the hosted page.
 *  This will be translated into setting the HTML placeholder attribute.
 *
 *  @param placeholder `NSString` representing the placeholder text.
 */
- (void)cvvPlaceholder:(NSString *)placeholder;

/**
 *  This is a convenience method for creating `BNCCHostedFormParams` params.
 *  This allows you to specify the CSS url used by the hosted page, all placeholders and the submit button text.
 *  This can of course be done via the properties aswell.
 *
 *  @param css                   `NSString` containing and url to a CSS file.
 *  @param cardNumberPlaceholder `NSString` representing the placeholder test for CC input group.
 *  @param expiryPlaceholder     `NSString` representing the placeholder test for Expiry input group.
 *  @param cvvPlaceholder        `NSString` representing the placeholder test for CVV/CVC input group.
 *  @param submitText            `NSString` representing the text for the sumbit button.
 *
 *  @return An instance of `BNCCHostedFormParams`.
 */
+ (BNCCHostedFormParams *)hostedFormParamsWithCSS:(NSString *)css
                            cardNumberPlaceholder:(NSString *)cardNumberPlaceholder
                                expiryPlaceholder:(NSString *)expiryPlaceholder
                                   cvvPlaceholder:(NSString *)cvvPlaceholder
                                       submitText:(NSString *)submitText;

+ (BNCCHostedFormParams *)mockObject;

@end
