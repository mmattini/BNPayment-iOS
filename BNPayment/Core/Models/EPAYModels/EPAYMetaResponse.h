//
//  BNEPAYMetaResponse.h
//  Pods
//
//  Created by Bambora On Mobile AB on 22/02/2016.
//
//

#import "BNBaseModel.h"

@class EPAYAction;
@class EPAYMessage;

@interface EPAYMetaResponse : BNBaseModel

@property (nonatomic, strong) EPAYAction *action;
@property (nonatomic, strong) EPAYMessage *message;
@property (nonatomic, assign) BOOL result;

@end
