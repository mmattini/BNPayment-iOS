//
//  BNCCFormInputModel.m
//  Pods
//
//  Created by Bambora On Mobile AB on 14/01/2016.
//
//

#import "BNCCFormInputModel.h"
#import "BNCCFormInputView.h"

@interface BNCCFormInputModel()

@property(nonatomic, strong) BNCCFormInputView *formView;

@end

@implementation BNCCFormInputModel

- (UIView *)generateInputViewWithFrame:(CGRect)frame {
    self.formView = [[BNCCFormInputView alloc] initWithModel:self
                                                    andFrame:frame];
    [super setupInputView];
    return self.formView;
}

@end
