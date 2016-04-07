//
//  UIView+BNUtils.m
//  Pods
//
//  Created by Oskar Henriksson on 13/01/2016.
//
//

#import "UIView+BNUtils.h"

@implementation UIView (BNUtils)

- (void)setYoffset:(NSInteger)yOffset {
    CGRect tmpRect = self.frame;
    tmpRect.origin.y = yOffset;
    self.frame = tmpRect;
}

- (void)setXoffset:(NSInteger)xOffset {
    CGRect tmpRect = self.frame;
    tmpRect.origin.x = xOffset;
    self.frame = tmpRect;
}

- (void)setHeight:(NSInteger)height {
    CGRect tmpRect = self.frame;
    tmpRect.size.height = height;
    self.frame = tmpRect;
}

- (void)setWidth:(NSInteger)width {
    CGRect tmpRect = self.frame;
    tmpRect.size.width = width;
    self.frame = tmpRect;
}

- (void)setCornerRadius:(NSInteger)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

@end
