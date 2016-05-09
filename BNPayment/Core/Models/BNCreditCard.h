//
//  BNCreditCard.h
//  Pods
//
//  Created by Bambora On Mobile AB on 12/01/2016.
//
//

#import "BNBaseModel.h"

/**
 *  `BNCreditCard` represents an credit card from the native form.
 */
@interface BNCreditCard : BNBaseModel

@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *cardNumber;
@property (nonatomic, strong) NSString *expMonth;
@property (nonatomic, strong) NSString *expYear;
@property (nonatomic, strong) NSString *cvv;

- (BNCreditCard *)encryptedCreditCardWithSessionKey:(NSData *)sessionKey;

@end
