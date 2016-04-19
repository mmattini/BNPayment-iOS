//
//  BNPaymentHandler.m
//  Pods
//
//  Created by Bambora On Mobile AB on 13/11/2015.
//
//

#import "BNPaymentHandler.h"
#import "BNPaymentEndpoint.h"
#import "BNCreditCardEndpoint.h"
#import "BNAuthorizedCreditCard.h"
#import "BNCCHostedFormParams.h"
#import "BNRegisterCCParams.h"
#import "BNPaymentParams.h"
#import <BNBase/BNCacheManager.h>

NSString *const TokenizedCreditCardCacheName = @"tokenizedCreditCardCacheName";

@interface BNPaymentHandler ()

@property (nonatomic, strong) NSMutableArray<BNAuthorizedCreditCard *> *tokenizedCreditCards;

@end

@implementation BNPaymentHandler

+ (BNPaymentHandler *)sharedInstance {
    static BNPaymentHandler *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[BNPaymentHandler alloc] init];
        [_sharedInstance setupBNPaymentHandler];
    });
    
    return _sharedInstance;
}

- (void)setupBNPaymentHandler {
    id cachedCards = [[BNCacheManager sharedCache] getObjectWithName:TokenizedCreditCardCacheName];
    
    self.tokenizedCreditCards = [NSMutableArray new];

    if ([cachedCards isKindOfClass:[NSArray class]]) {
        self.tokenizedCreditCards = [cachedCards mutableCopy];
    }
}

- (NSURLSessionDataTask *)initiateCreditCardRegistrationWithParams:(BNCCHostedFormParams * )params
                                                        completion:(BNCreditCardRegistrationUrlBlock) block {
    NSURLSessionDataTask *dataTask = [BNCreditCardEndpoint initiateCreditCardRegistrationForm:params
                                                                                   completion:^(NSString *url, NSError *error) {
        block(url, error);
    }];
    
    return dataTask;
}

+ (NSURLSessionDataTask *)registerCreditCard:(BNRegisterCCParams *)params
                                  completion:(BNCreditCardRegistrationBlock)completion {
    NSURLSessionDataTask *dataTask = [BNCreditCardEndpoint registerCreditCard:params completion:completion];
    return dataTask;
}

- (NSURLSessionDataTask *)makePaymentWithParams:(BNPaymentParams *)paymentParams
                                         result:(BNPaymentBlock) result {
    NSURLSessionDataTask *dataTask = [BNPaymentEndpoint authorizePaymentWithParams:paymentParams
                                                                        completion:^(BNPaymentResponse *paymentResponse,
                                                                                     NSError *error) {
        result(paymentResponse ? BNPaymentSuccess : BNPaymentFailure, error);
    }];

    return dataTask;
}

- (NSArray <BNAuthorizedCreditCard *>*)authorizedCards {
    return self.tokenizedCreditCards;
}

- (void)saveAuthorizedCreditCard:(BNAuthorizedCreditCard *)authorizedCreditCard {
    if (self.tokenizedCreditCards) {
        [self.tokenizedCreditCards removeObject:authorizedCreditCard];
        [self.tokenizedCreditCards addObject:authorizedCreditCard];
        [[BNCacheManager sharedCache] saveObject:self.tokenizedCreditCards
                                        withName:TokenizedCreditCardCacheName];
    }
}

- (void)removeAuthorizedCreditCard:(BNAuthorizedCreditCard *)authorizedCreditCard {
    if (self.tokenizedCreditCards) {
        [self.tokenizedCreditCards removeObject:authorizedCreditCard];
        [[BNCacheManager sharedCache] saveObject:self.tokenizedCreditCards
                                        withName:TokenizedCreditCardCacheName];
    }
}

@end
