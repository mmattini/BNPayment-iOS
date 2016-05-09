//
//  BNHTTPClient.m
//  Pods
//
//  Created by Bambora On Mobile AB on 15/09/2015.
//
//

#import "BNHTTPClient.h"
#import "BNHTTPRequestSerializer.h"
#import "BNHTTPResponseSerializer.h"
#import "BNPaymentHandler.h"
#import "BNSecurity.h"
#import "NSString+BNLogUtils.h"
#import "BNRegistrationEndpoint.h"
#import "BNAuthenticator.h"
#import "NSURLRequest+BNAuth.h"

@import QuartzCore;

@interface BNHTTPClient()

@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) NSURLSessionConfiguration *configuration;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) BNHTTPRequestSerializer *requestSerializer;
@property (nonatomic, strong) BNHTTPResponseSerializer *responseSerializer;
@property (nonatomic, strong) BNSecurity *networkSecurity;
@property (nonatomic, strong) NSMutableArray *pendingTasks;
@property (nonatomic, assign) BOOL enableLogging;
@property (nonatomic, assign) BOOL registrationOngoing;

@end

@implementation BNHTTPClient

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super init];
    
    if (self) {
        [self setupHTTPClientWithURL:url];
    }
    
    return self;
    
}

- (void)enableLogging:(BOOL)enableLogging {
    self.enableLogging = enableLogging;
}

- (void)setupHTTPClientWithURL:(NSURL *)url {
    self.baseURL = url;
    self.configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 1;
    
    self.requestSerializer = [BNHTTPRequestSerializer new];
    self.responseSerializer = [BNHTTPResponseSerializer new];
    
    self.networkSecurity = [BNSecurity new];
    
    self.session = [NSURLSession sessionWithConfiguration:self.configuration delegate:self delegateQueue:self.operationQueue];
    
    self.pendingTasks = [NSMutableArray new];
}

- (NSURLSessionDataTask *)GET:(NSString *)endpointURLString
                   parameters:(NSDictionary *)params
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSURLSessionDataTask *dataTask =  [self dataTaskWithHTTPMethod:@"GET"
                                                            params:params
                                                       endpointUrl:endpointURLString
                                                           success:success
                                                           failure:failure];
    if(![[BNPaymentHandler sharedInstance] isRegistered]) {
        [self registerSDKWithPendingTask:dataTask];
    }else {
        [dataTask resume];
    }
    
    return dataTask;
    
}

- (NSURLSessionDataTask *)POST:(NSString *)endpointURLString
                    parameters:(NSDictionary *)params
                       success:(BNHTTPClientSuccessBlock)success
                       failure:(BNHTTPClientErrorBlock)failure {
    
    NSURLSessionDataTask *dataTask =  [self dataTaskWithHTTPMethod:@"POST"
                                                            params:params
                                                       endpointUrl:endpointURLString
                                                           success:success
                                                           failure:failure];
    
    if(![[BNPaymentHandler sharedInstance] isRegistered]) {
        [self registerSDKWithPendingTask:dataTask];
    }else {
        [dataTask resume];
    }
    
    return dataTask;
    
}

- (NSURLSessionDataTask *)PUT:(NSString *)endpointURLString
                   parameters:(NSDictionary *)params
                      success:(BNHTTPClientSuccessBlock)success
                      failure:(BNHTTPClientErrorBlock)failure {
    
    NSURLSessionDataTask *dataTask =  [self dataTaskWithHTTPMethod:@"PUT"
                                                            params:params
                                                       endpointUrl:endpointURLString
                                                           success:success
                                                           failure:failure];
    if(![[BNPaymentHandler sharedInstance] isRegistered]) {
        [self registerSDKWithPendingTask:dataTask];
    }else {
        [dataTask resume];
    }
    
    return dataTask;
}

- (NSURLSessionDataTask *)DELETE:(NSString *)endpointURLString
                      parameters:(NSDictionary *)params
                         success:(BNHTTPClientSuccessBlock)success
                         failure:(BNHTTPClientErrorBlock)failure {
    
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"DELETE"
                                                       params:params
                                                  endpointUrl:endpointURLString
                                                          success:success
                                                          failure:failure];
    if(![[BNPaymentHandler sharedInstance] isRegistered]) {
        [self registerSDKWithPendingTask:dataTask];
    }else {
        [dataTask resume];
    }
    
    return dataTask;
    
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)httpMethod
                                          params:(NSDictionary *)params
                                     endpointUrl:(NSString *)endpointURL
                                         success:(BNHTTPClientSuccessBlock)success
                                         failure:(BNHTTPClientErrorBlock)failure {
    
    __block CFTimeInterval startTime;
    
    NSString *requestURL = [[NSURL URLWithString:endpointURL relativeToURL:self.baseURL] absoluteString];
    
    NSError *serializationError;
    
    NSURLRequest *request = [self.requestSerializer requestWithMethod:httpMethod
                                                            URLString:requestURL
                                                           parameters:params
                                                                error:&serializationError];
    
    if (self.enableLogging) {
        startTime = CACurrentMediaTime();
        NSLog(@"%@", [NSString logentryWithTitle:endpointURL message:params.descriptionInStringsFileFormat]);
        NSLog(@"Headers %@", [request allHTTPHeaderFields]);
    }
    
    if (serializationError) {
        failure(nil, serializationError);
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.session dataTaskWithRequest:request
                               completionHandler:^(NSData *data,
                                                   NSURLResponse *response,
                                                   NSError * error) {
                                   
                                   if (self.enableLogging) {
                                       NSString *responseDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                       CFTimeInterval requestDeltaTime = (CACurrentMediaTime()-startTime)*1000;
                                       
                                       NSString *title = [NSString stringWithFormat:@"Request to %@ ended (%f ms)", endpointURL, requestDeltaTime];
                                       NSString *message = [NSString stringWithFormat:@"Response\n%@\n%@", response, responseDataString];
                                       
                                       NSLog(@"%@", [NSString logentryWithTitle:title message:message]);
                                   }
                                   
                                   if (error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           failure(dataTask, error);
                                       });
                                   } else {
                                       NSError *serializationError;
                                       id responseObject = [self.responseSerializer responseObjectForResponse:dataTask.response
                                                                                                         data:data
                                                                                                        error:&serializationError];
                                       if (serializationError) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               failure(dataTask, serializationError);
                                           });
                                       } else {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               success(dataTask, responseObject);
                                           });
                                       }
                                   }
                               }];
    return dataTask;
}

#pragma mark - NSURLSessionDelegate methods

- (void)URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition,
                             NSURLCredential *credential))completionHandler {
    
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        BOOL trustServer = [self.networkSecurity evaluateServerTrust:challenge.protectionSpace.serverTrust
                                                           forDomain:challenge.protectionSpace.host];
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        disposition = trustServer ? NSURLSessionAuthChallengeUseCredential : NSURLSessionAuthChallengeCancelAuthenticationChallenge;
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}

- (void)registerSDKWithPendingTask:(NSURLSessionDataTask *)pendingTask {
    if(![pendingTask.originalRequest.URL.path containsString:@"credentials"]) {
        [self.pendingTasks addObject:pendingTask];
    }
    
    if(!self.registrationOngoing) {
        self.registrationOngoing = YES;
        
        NSURLSessionDataTask *task = [BNRegistrationEndpoint registerWithUser:nil completion:^(BNAuthenticator *authenticator, NSError *error) {
            if (authenticator) {
                [[BNPaymentHandler sharedInstance] registerAuthenticator:authenticator];
            }
            
            for(NSURLSessionDataTask *task in self.pendingTasks) {
                NSURLRequest *newRequest = [task.currentRequest addAuthHeaderWithAuthenticator:authenticator];
                if(newRequest) {
                    [task setValue:newRequest forKey:@"currentRequest"];
                }
                [task resume];
            }
        }];
        
        [task resume];
    }
}

@end

