//
//  BNFormToolbar.h
//  Pods
//
//  Created by Bambora On Mobile AB on 15/01/2016.
//
//

#import <UIKit/UIKit.h>

@interface BNFormToolbar : UIToolbar

@property (nonatomic, copy) void (^doneBlock)(void);

@end
