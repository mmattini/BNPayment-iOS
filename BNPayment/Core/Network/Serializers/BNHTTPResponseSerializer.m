//
//  BNHTTPResponseSerializer.m
//  Pods
//
//  Created by Bambora On Mobile AB on 21/01/2016.
//
//

#import "BNHTTPResponseSerializer.h"

NSString * const BNResponseSerializationDomain = @"com.bambora.error.serialization.response";
NSString * const BNResponseSerializationErrorData = @"com.bambora.error.serialization.data";
NSString * const BNResponseSerializationErrorDataString = @"com.bambora.error.serialization.data.string";

@interface BNHTTPResponseSerializer ()

@property (readwrite, nonatomic, strong) NSIndexSet *acceptableStatusCodes;

@end

@implementation BNHTTPResponseSerializer

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
    }
    
    return self;
}

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError **)error {

    id responseObject = nil;

    NSError *validationError;
    if ([self validateResponse:(NSHTTPURLResponse *)response
                          data:data
                         error:&validationError]) {
        NSError *serializationError = nil;

        @autoreleasepool {
            NSString *responseString = [[NSString alloc] initWithData:data
                                                             encoding:NSUTF8StringEncoding];
            if (responseString && ![responseString isEqualToString:@" "]) {
                data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                
                if (data && [data length] > 0) {
                    responseObject = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions error:&serializationError];
                }
            }
        }
        
        *error = serializationError;
    }
    
    if (validationError) {
        *error = validationError;
    }
    
    return responseObject;
}

- (BOOL)validateResponse:(NSHTTPURLResponse *)response
                    data:(NSData *)data
                   error:(NSError **)error {

    if (response && [response isKindOfClass:[NSHTTPURLResponse class]]) {

        if (self.acceptableStatusCodes
            && ![self.acceptableStatusCodes containsIndex:(NSUInteger)response.statusCode]
            && [response URL]) {
            NSMutableDictionary *userInfo = [@{
                NSLocalizedDescriptionKey:[NSString stringWithFormat:@"Expect HTTP status in range 200-299 got: %ld", (long)[response statusCode]],
                NSURLErrorFailingURLErrorKey:[response URL],
            } mutableCopy];
            
            if (data) {
                NSString *responseDataString = [[NSString alloc] initWithData:data
                                                                     encoding:NSUTF8StringEncoding];

                userInfo[BNResponseSerializationErrorData] = data;
                if (responseDataString) {
                    userInfo[BNResponseSerializationErrorDataString] = responseDataString;
                }
            }
            
            if (error != nil) {
                *error = [[NSError alloc] initWithDomain:BNResponseSerializationDomain
                                                    code:[response statusCode]
                                                userInfo:userInfo];
            }
            
            return NO;
        }
        
        if (![[response MIMEType] isEqualToString:@"application/json"]) {
            NSMutableDictionary *userInfo = [@{
                NSLocalizedDescriptionKey:[NSString stringWithFormat:@"MIME type not supported: %@", [response MIMEType]],
                NSURLErrorFailingURLErrorKey:[response URL],
            } mutableCopy];
            
            if (data) {
                NSString *responseDataString = [[NSString alloc] initWithData:data
                                                                     encoding:NSUTF8StringEncoding];

                userInfo[BNResponseSerializationErrorData] = data;
                
                if (responseDataString) {
                    userInfo[BNResponseSerializationErrorDataString] = responseDataString;
                }
            }
            
            if (error != NULL) {
                *error = [[NSError alloc] initWithDomain:BNResponseSerializationDomain
                                                    code:[response statusCode]
                                                userInfo:userInfo];
            }
            
            return NO;
        }
    
    }
    
    return YES;
}

@end
