//
//  BNFormModel.h
//  Pods
//
//  Created by Bambora On Mobile AB on 14/01/2016.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNFormModel : NSObject

@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) UIButton *submitButton;

/**
 *  Generate a dictionary representation of the `BNFormModel`
 *
 *  @return A dictionary representation of the instance.
 */
- (NSDictionary *)generateFormDictionary;

@end
