//
//  BNCCRegistrationFormVC.h
//  Pods
//
//  Created by Bambora On Mobile AB on 12/01/2016.
//
//

#import "BNEnums.h"
#import "BNPaymentBaseVC.h"

@class BNCreditCard;
@class BNAuthorizedCreditCard;

/**
 *  A block indicating whether or not the `BNCCRegistrationFormVC` is done
 *
 *  @param success The status of the operation
 */
typedef void(^BNCCRegistrationFormCompletion)(BNCCRegCompletion completion, BNAuthorizedCreditCard *card);

/**
 *  `BNCCRegistrationFormVC` is a view controller that displays a form for credit card registration.
 */
@interface BNCCRegistrationFormVC : BNPaymentBaseVC

@property (nonatomic, copy) BNCCRegistrationFormCompletion completionBlock;

- (void)updateFormModelWithCardInfo:(BNCreditCard *)creditCard;

@end
