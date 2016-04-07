//
//  BNFormScrollView.m
//  Pods
//
//  Created by Bambora On Mobile AB on 14/01/2016.
//
//

#import "BNFormScrollView.h"
#import "UIView+BNUtils.h"
#import "BNFormModel.h"
#import "BNFormInputModel.h"
#import "BNFormToolbar.h"

@interface BNFormScrollView()

@property (nonatomic, strong) BNFormModel *formModel;
@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) BNFormView *activeFormView;
@property (nonatomic, strong) BNFormToolbar *inputAncessoryView;

@end

@implementation BNFormScrollView

- (void)setupWithModel:(BNFormModel *)formModel {
    self.formModel = formModel;

    [self createViews];
}

- (void)createViews {
    [self setupAcessoryInputView];
    
    self.views = [[NSMutableArray alloc] initWithCapacity:self.formModel.models.count + 1];
    for(BNFormInputModel *formInputModel in self.formModel.models) {
        BNFormView *formView = (BNFormView *)[formInputModel generateInputViewWithFrame:CGRectMake(0,
                                                                                                   0,
                                                                                                   CGRectGetWidth(self.frame),
                                                                                                   0)];
        formView.inputTextField.inputAccessoryView = self.inputAncessoryView;
        formView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        formView.delegate = self;
        [self addSubview:formView];
        [self.views addObject:formView];
    }
    
    self.formModel.submitButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.views addObject:self.formModel.submitButton];
    [self addSubview:self.formModel.submitButton];
    [self stackViews];
    
}

- (void)setupAcessoryInputView {
    self.inputAncessoryView = [BNFormToolbar new];
    
    __weak BNFormScrollView *weakSelf = self;
    self.inputAncessoryView.doneBlock = ^{[weakSelf doneClicked:nil];};
}

- (void)stackViews {
    for(int i = 1; i < self.views.count; i++) {
        UIView *lastView = [self.views objectAtIndex:i-1];
        UIView *currentView = [self.views objectAtIndex:i];
        
        NSInteger margin = [currentView isKindOfClass:[BNFormView class]] ? 0 : 8;
        
        [currentView setYoffset:CGRectGetMaxY(lastView.frame)+margin];
        
        if (i == self.views.count-1) {
            [self setContentSize:CGSizeMake(self.contentSize.width,
                                            CGRectGetMaxY(currentView.frame))];
        }
    }
}

- (void)formViewDidBecomeFirstResponder:(BNFormView *)formView {
    self.activeFormView = formView;
    
    [self scrollFrameFullyVisible:formView.frame animation:YES];
}

- (void)keyboardWillShowWithSize:(CGSize)kbSize
           andAnimationDuration:(CGFloat)animationDuration
               andAnimationCurve:(UIViewAnimationCurve)animationCurve {
    
    self.bottomMargin.constant = kbSize.height;

    __weak BNFormView *weakActiveView = self.activeFormView;

    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [UIView setAnimationCurve:animationCurve];
        [self.superview layoutIfNeeded];
        [self scrollFrameFullyVisible:weakActiveView.frame
                            animation:NO];
    } completion:^(BOOL finished) {
    }];
    
}

- (void)keyboardWillHideWithSize:(CGSize)kbSize
           andAnimationDuration:(CGFloat)animationDuration
               andAnimationCurve:(UIViewAnimationCurve)animationCurve {
    self.bottomMargin.constant = 0;

    __weak BNFormView *weakActiveView = self.activeFormView;
    
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [UIView setAnimationCurve:animationCurve];
        [self.superview layoutIfNeeded];
        [self scrollFrameFullyVisible:weakActiveView.frame
                            animation:NO];
    } completion:^(BOOL finished) {
    }];
    
}

- (void)doneClicked:(id)sender {
    if (self.activeFormView) {
        [self.activeFormView.inputTextField resignFirstResponder];
    }
}

- (void)scrollFrameFullyVisible:(CGRect)frame animation:(BOOL)animation {
    CGRect visibleRect = CGRectMake(0,
                                    self.contentOffset.y,
                                    CGRectGetWidth(self.bounds),
                                    CGRectGetHeight(self.bounds));
    
    CGFloat maxYFrame = CGRectGetMaxY(frame);
    CGFloat maxYvisibleFrame = CGRectGetMaxY(visibleRect);
    
    CGFloat minYFrame = CGRectGetMinY(frame);
    CGFloat minYVisibleFrame = CGRectGetMinY(visibleRect)+self.contentInset.top;

    CGPoint newContentOffset = self.contentOffset;
    
    if (maxYFrame > maxYvisibleFrame) {
        newContentOffset.y += maxYFrame-maxYvisibleFrame;
    }else if (minYFrame < minYVisibleFrame) {
        newContentOffset.y -= minYVisibleFrame-minYFrame;
    }
    
    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentOffset = newContentOffset;
    } completion:nil];
}

@end
