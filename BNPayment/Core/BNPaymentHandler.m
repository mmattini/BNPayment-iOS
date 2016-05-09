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
#import "BNCacheManager.h"
#import "BNCCHostedFormParams.h"
#import "BNRegisterCCParams.h"
#import "BNPaymentParams.h"
#import "BNAuthenticator.h"
#import "BNHTTPClient.h"
#import "BNUser.h"

static NSString *const TokenizedCreditCardCacheName = @"tokenizedCreditCardCacheName";
static NSString *const BNAuthenticatorCacheName = @"BNAuthenticator";
static NSString *const SharedSecretKeychainKey = @"sharedSecret";
static NSString *const DefaultBaseUrl = @"https://ironpoodle-prod-eu-west-1.aws.bambora.com/";

@interface BNPaymentHandler ()

@property (nonatomic, strong) NSMutableArray<BNAuthorizedCreditCard *> *tokenizedCreditCards;
@property (nonatomic, strong) NSString *apiToken;
@property (nonatomic, assign) BOOL debug;
@property (nonatomic, assign) NSString *baseUrl;
@property (nonatomic, strong) BNAuthenticator *autenticator;
@property (nonatomic, strong) BNHTTPClient *httpClient;

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

+ (BOOL)setupWithApiToken:(NSString *)apiToken
                  baseUrl:(NSString *)baseUrl
                    debug:(BOOL)debug
                    error:(NSError **)error {
    
    BNPaymentHandler *handler = [BNPaymentHandler sharedInstance];
    handler.apiToken = apiToken;
    handler.baseUrl = baseUrl ? baseUrl : DefaultBaseUrl;
    handler.debug = debug;
    handler.httpClient = [[BNHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:handler.baseUrl]];
    [handler.httpClient enableLogging:debug];
    
    return error == nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        id authenticator = [[BNCacheManager sharedCache] getObjectWithName:BNAuthenticatorCacheName];
        if ([authenticator isKindOfClass:[BNAuthenticator class]]) {
            self.autenticator = authenticator;
        }
    }
    return self;
}

- (void)setupBNPaymentHandler {
    id cachedCards = [[BNCacheManager sharedCache] getObjectWithName:TokenizedCreditCardCacheName];
    
    self.tokenizedCreditCards = [NSMutableArray new];
    
    if ([cachedCards isKindOfClass:[NSArray class]]) {
        self.tokenizedCreditCards = [cachedCards mutableCopy];
    }
}

- (BNHTTPClient *)getHttpClient {
    return self.httpClient;
}

- (void)registerAuthenticator:(BNAuthenticator *)authenticator {
    self.autenticator = authenticator;
    [[BNCacheManager sharedCache] saveObject:self.authenticator
                                    withName:BNAuthenticatorCacheName];
}

- (BNAuthenticator *)authenticator {
    return self.autenticator;
}

- (BOOL)isRegistered {
    return self.autenticator != nil;
}

- (NSString *)getApiToken {
    return self.apiToken;
}

- (NSString *)getBaseUrl {
    return self.baseUrl;
}

- (BOOL)debugMode {
    return self.debug;
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
