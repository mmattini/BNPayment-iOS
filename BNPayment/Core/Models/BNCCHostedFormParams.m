//
//  BNCCHostedFormParams.m
//  Pods
//
//  Created by Bambora On Mobile AB on 05/02/2016.
//
//

#import "BNCCHostedFormParams.h"
#import "BNCCFormInputGroup.h"

@implementation BNCCHostedFormParams {
    BNCCFormInputGroup *_cardNumberInputGroup;
    BNCCFormInputGroup *_cvvInputGroup;
    BNCCFormInputGroup *_expiryDateInputGroup;
}

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"cssURL" : @"cssurl",
             @"platform" : @"platform",
             @"inputGroups" : @"inputgroups",
             @"submitButtonText": @"submitbutton"
             };
}

- (instancetype)init {
    self = [super init];
    
    if(self) {
        self.platform = @"ios";

        _cardNumberInputGroup = [BNCCFormInputGroup new];
        _cardNumberInputGroup.name = @"cardnumber";

        _expiryDateInputGroup = [BNCCFormInputGroup new];
        _expiryDateInputGroup.name = @"cardexpiry";

        _cvvInputGroup = [BNCCFormInputGroup new];
        _cvvInputGroup.name = @"cardverification";
        
        self.inputGroups = @[_cardNumberInputGroup,_expiryDateInputGroup,_cvvInputGroup];
    }
    
    return self;
}

- (void)CCNumberPlaceholder:(NSString *)placeholder {
    _cardNumberInputGroup.placeholder = placeholder;
}

- (void)expiryPlaceholder:(NSString *)placeholder {
    _expiryDateInputGroup.placeholder = placeholder;
}

- (void)cvvPlaceholder:(NSString *)placeholder {
    _cvvInputGroup.placeholder = placeholder;
}

+ (BNCCHostedFormParams *)hostedFormParamsWithCSS:(NSString *)css
                            cardNumberPlaceholder:(NSString *)cardNumberPlaceholder
                                expiryPlaceholder:(NSString *)expiryPlaceholder
                                   cvvPlaceholder:(NSString *)cvvPlaceholder
                                       submitText:(NSString *)submitText {
    
    BNCCHostedFormParams *params = [BNCCHostedFormParams new];
    
    params.cssURL = css;
    params.submitButtonText = submitText;
    
    [params CCNumberPlaceholder:cardNumberPlaceholder];
    [params expiryPlaceholder:expiryPlaceholder];
    [params cvvPlaceholder:cvvPlaceholder];
    
    return params;
}

+ (BNCCHostedFormParams *)mockObject {
    BNCCHostedFormParams *params = [BNCCHostedFormParams new];
    
    params.cssURL = @"http://ci.mobivending.com/CNP/example.css";
    params.submitButtonText = @"Save card";

    [params CCNumberPlaceholder:@"Card number"];
    [params expiryPlaceholder:@"MM/YY"];
    [params cvvPlaceholder:@"CVV/CVC"];
    
    return params;
}

@end
