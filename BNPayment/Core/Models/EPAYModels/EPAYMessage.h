//
//  EPAYMessage.h
//  Pods
//
//  Created by Bambora On Mobile AB on 22/02/2016.
//
//

#import "BNBaseModel.h"

@interface EPAYMessage : BNBaseModel

@property (nonatomic, strong) NSString *enduser;
@property (nonatomic, strong) NSString *merchant;

@end
