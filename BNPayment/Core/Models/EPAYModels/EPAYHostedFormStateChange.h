//
//  EPAYHostedFormStateChange.h
//  Pods
//
//  Created by Bambora On Mobile AB on 22/02/2016.
//
//

#import <BNBase/BNBaseModel.h>

@class EPAYMetaResponse;
@class BNAuthorizedCreditCard;

static NSInteger const EPAYSubmissionStarted = 100;     // Ajax request started
static NSInteger const EPAYSuccess = 200;               // Ajax request successfully completed
static NSInteger const EPAYSubmissionDeclined = 300;    // Ajax request failed
static NSInteger const EPAYSystemError = 1000;          // System error
static NSInteger const EPAYUnknown = 9999;              // Unknown

@interface EPAYHostedFormStateChange : BNBaseModel

@property (nonatomic, strong) EPAYMetaResponse *meta;
@property (nonatomic, strong) NSString *truncatedCardNumber;
@property (nonatomic, strong) NSNumber *expiryMonth;
@property (nonatomic, strong) NSNumber *expiryYear;
@property (nonatomic, strong) NSString *paymentType;
@property (nonatomic, strong) NSString *subscriptionId;

- (BNAuthorizedCreditCard *)generateAuthorizedCard;

- (NSInteger)status;

@end
