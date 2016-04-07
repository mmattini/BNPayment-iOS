//
//  UIImage+BNUtils.h
//  Pods
//
//  Created by Oskar Henriksson on 13/01/2016.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (BNUtils)

/**
 *  A helper method for loading an image from a specific bundle-
 *
 *  @param name   `NSString` representing the name of the image.
 *  @param bundle `NSBundle` contaning the image.
 *
 *  @return `UIImage` loaded
 */
+ (UIImage *)loadImageWithName:(NSString *)name
                    fromBundle:(NSBundle *)bundle;

@end
