//
//  UIImage+BNUtils.m
//  Pods
//
//  Created by Oskar Henriksson on 13/01/2016.
//
//

#import "UIImage+BNUtils.h"

@implementation UIImage (BNUtils)

+ (UIImage *)loadImageWithName:(NSString *)name
                    fromBundle:(NSBundle *)bundle {
    UIImage *image = [UIImage imageNamed:name
                                inBundle:bundle
           compatibleWithTraitCollection:nil];
    
    return image;
}

@end
