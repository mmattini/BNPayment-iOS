//
//  BNRegisterCCParams.h
//  BNPayment
//
//  Created by Oskar Henriksson on 19/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import "BNBaseModel.h"

@class BNCreditCard;

@interface BNRegisterCCParams : BNBaseModel

- (instancetype)initWithCreditCard:(BNCreditCard *)creditCard;

@end
