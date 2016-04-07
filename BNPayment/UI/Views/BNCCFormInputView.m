//
//  BNCCFormInputView.m
//  Pods
//
//  Created by Bambora On Mobile AB on 12/01/2016.
//
//

#import "BNCCFormInputView.h"
#import "BNCCFormInputModel.h"
#import "BNBundleUtils.h"

@interface BNCCFormInputView()

@property (nonatomic, strong) IBOutlet UIImageView *iconImageView;

@end

@implementation BNCCFormInputView {
    BNCCFormInputView *_childFormView;
}

- (instancetype)initWithModel:(BNCCFormInputModel *)model andFrame:(CGRect)frame {
    frame.size.height = 44;
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitWithViewName:@"BNCCFormInputView" andBundle:[BNBundleUtils paymentLibBundle]];
        [self setupViewWithModel:model];
    }
    
    return self;
}

- (void)setupViewWithModel:(BNCCFormInputModel *)model{
    [super setupViewWithModel:model];
    _childFormView = (BNCCFormInputView *)self.containerView;
    _iconImageView = _childFormView.iconImageView;
    _iconImageView.image = model.iconImage;
}

@end
