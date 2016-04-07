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

- (void)CCNumberPlaceholder:(NSString *)placeholder;
- (void)expiryPlaceholder:(NSString *)placeholder;
- (void)cvvPlaceholder:(NSString *)placeholder;

+ (BNCCHostedFormParams *)hostedFormParamsWithCSS:(NSString *)css
                            cardNumberPlaceholder:(NSString *)cardNumberPlaceholder
                                expiryPlaceholder:(NSString *)expiryPlaceholder
                                   cvvPlaceholder:(NSString *)cvvPlaceholder
                                       submitText:(NSString *)submitText;

+ (BNCCHostedFormParams *)mockObject;

@end
