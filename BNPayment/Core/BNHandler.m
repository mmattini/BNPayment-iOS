//
//  BNHandler.m
//  Pods
//
//  Created by Bambora On Mobile AB on 16/09/2015.
//
//

#import "BNHandler.h"
#import "BNCacheManager.h"
#import "BNRegistrationEndpoint.h"

static NSString *const BNAuthenticatorCacheName = @"BNAuthenticator";
static NSString *const SharedSecretKeychainKey = @"sharedSecret";
static NSString *const DefaultBaseUrl = @"https://ironpoodle-prod-eu-west-1.aws.bambora.com/";

@interface BNHandler()

@property (nonatomic, strong) NSString *apiToken;
@property (nonatomic, assign) BOOL debug;
@property (nonatomic, assign) NSString *baseUrl;
@property (nonatomic, strong) BNAuthenticator *autenticator;
@property (nonatomic, strong) BNHTTPClient *httpClient;

@end

@implementation BNHandler

+ (BNHandler *)sharedInstance {
    static BNHandler *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[BNHandler alloc] init];
    });
    
    return _sharedInstance;
}

+ (BOOL)setupWithApiToken:(NSString *)apiToken
                  baseUrl:(NSString *)baseUrl
                    debug:(BOOL)debug
                    error:(NSError **)error {
    
    BNHandler *handler = [BNHandler sharedInstance];
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

- (void)registerUser:(BNUser *)user completion:(void (^) (BOOL))success {
    [BNRegistrationEndpoint registerWithUser:user
                                       completion:^(BNAuthenticator *authenticator, NSError *error) {
        if (authenticator) {
            [[BNHandler sharedInstance] registerAuthenticator:authenticator];
        }
                                           
        success(authenticator != nil);
    }];
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

@end
