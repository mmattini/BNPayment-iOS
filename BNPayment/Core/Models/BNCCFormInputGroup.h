//
//  BNCCFormInputGroup.h
//  Pods
//
//  Created by Bambora On Mobile AB on 05/02/2016.
//
//

#import "BNBaseModel.h"

/**
 *  `BNCCFormInputGroup` represents the params for an input group in the hosted page.
 */
@interface BNCCFormInputGroup : BNBaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *value;

@end
