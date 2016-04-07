
//
//  BNHostedRegistrationFormFooter.m
//  Pods
//
//  Created by Bambora On Mobile AB on 12/02/2016.
//
//

#import "BNHostedRegistrationFormFooter.h"

@interface BNHostedRegistrationFormFooter ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation BNHostedRegistrationFormFooter


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.numberOfLines = 0;
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:12.f];
        self.textLabel.text = @"Secure payments provided by Bambora\nVISA and MasterCard are accepted";
        self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [self addSubview:self.textLabel];
    }
    
    return self;
}


@end
