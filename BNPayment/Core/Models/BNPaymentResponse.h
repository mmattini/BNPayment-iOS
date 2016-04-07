//
//  BNPaymentResponse.h
//  Pods
//
//  Created by Bambora On Mobile AB on 17/02/2016.
//
//

#import <BNBase/BNBaseModel.h>

@interface BNPaymentResponse : BNBaseModel

@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *merchant;
@property (nonatomic, strong) NSString *payment;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSArray *captures;

@end
