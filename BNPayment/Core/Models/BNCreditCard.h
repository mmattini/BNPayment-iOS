//
//  BNCreditCard.h
//  Pods
//
//  Created by Bambora On Mobile AB on 12/01/2016.
//
//

#import <BNBase/BNBaseModel.h>

/**
 *  `BNCreditCard` represents an credit card from the native form.
 */
@interface BNCreditCard : BNBaseModel

@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *cardNumber;
@property (nonatomic, strong) NSString *expiryDate;
@property (nonatomic, strong) NSString *cvv;

@end
