//
//  BNFormView.h
//  Pods
//
//  Created by Bambora On Mobile AB on 14/01/2016.
//
//

#import "BNBaseXibView.h"

@class BNFormView;
@class BNFormInputModel;

@protocol BNFormInputViewDelegate <NSObject>

- (void)formViewDidBecomeFirstResponder:(BNFormView *)formView;

@end

@interface BNFormView : BNBaseXIBView

- (instancetype)initWithModel:(BNFormInputModel *)model andFrame:(CGRect)frame;

- (void)setupViewWithModel:(BNFormInputModel *)model;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UITextField *inputTextField;
@property (nonatomic, weak) id <BNFormInputViewDelegate> delegate;

@end
