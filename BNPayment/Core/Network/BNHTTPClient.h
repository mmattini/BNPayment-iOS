//
//  BNHTTPClient.h
//
//  Created by Bambora On Mobile AB on 15/09/2015.
//

@import Foundation;

typedef void (^BNHTTPClientSuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^BNHTTPClientErrorBlock)(NSURLSessionDataTask *task, NSError *error);

/**
 *  `BNHTTPClient` is the HTTP client used for network communication by the SDK.
 *  `BNHTTPClient` only supports [GET, POST, PUT, DELETE] HTTP methods.
 *  `BNHTTPClient` only supports application/json content type and is made for consuming JSON rest APIs.
 */
@interface BNHTTPClient : NSObject <NSURLSessionDelegate>

/**
 *  Init method for `BNHTTPClient`.
 *
 *  @param url A `NSURL` representing the base URL to be used by the client.
 *
 *  @return An instance of `BNHTTPClient`.
 */
- (instancetype)initWithBaseURL:(NSURL *)url;

/**
 *  Enable logging allows you to view request information logged by NSLog.
 *  Default is NO logging.
 *
 *  @param enableLogging A flag indicating whether debug mode should be used.
 */
- (void)enableLogging:(BOOL)enableLogging;

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `GET` request.
 *
 *  @param endpointURLString The endpoint URL used for creating the request URL
 *  @param params            The params to be encoded by the serializer `BNHTTPRequestSerializer`.
 *  @param success           An object block executed when the request finished successfully. Dispatched to main queue.
 *  @param failure           An object block executed when the request finished with an error. Dispatched to main queue.
 *
 *  @return A `NSURLSessionDataTask` created by this method.
 */
- (NSURLSessionDataTask *)GET:(NSString *)endpointURLString
                   parameters:(NSDictionary *)params
                      success:(BNHTTPClientSuccessBlock)success
                      failure:(BNHTTPClientErrorBlock)failure;

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `POST` request.
 *
 *  @param endpointURLString The endpoint URL used for creating the request URL
 *  @param params            The params to be encoded by the serializer `BNHTTPRequestSerializer`.
 *  @param success           An object block executed when the request finished successfully. Dispatched to main queue.
 *  @param failure           An object block executed when the request finished with an error. Dispatched to main queue.
 *
 *  @return A `NSURLSessionDataTask` created by this method.
 */
- (NSURLSessionDataTask *)POST:(NSString *)endpointURLString
                    parameters:(NSDictionary *)params
                       success:(BNHTTPClientSuccessBlock)success
                       failure:(BNHTTPClientErrorBlock)failure;

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `PUT` request.
 *
 *  @param endpointURLString The endpoint URL used for creating the request URL
 *  @param params            The params to be encoded by the serializer `BNHTTPRequestSerializer`.
 *  @param success           An object block executed when the request finished successfully. Dispatched to main queue.
 *  @param failure           An object block executed when the request finished with an error. Dispatched to main queue.
 *
 *  @return A `NSURLSessionDataTask` created by this method.
 */
- (NSURLSessionDataTask *)PUT:(NSString *)endpointURLString
                   parameters:(NSDictionary *)params
                      success:(BNHTTPClientSuccessBlock)success
                      failure:(BNHTTPClientErrorBlock)failure;

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `DELETE` request.
 *
 *  @param endpointURLString The endpoint URL used for creating the request URL
 *  @param params            The params to be encoded by the serializer `BNHTTPRequestSerializer`.
 *  @param success           An object block executed when the request finished successfully. Dispatched to main queue.
 *  @param failure           An object block executed when the request finished with an error. Dispatched to main queue.
 *
 *  @return A `NSURLSessionDataTask` created by this method.
 */
- (NSURLSessionDataTask *)DELETE:(NSString *)endpointURLString
                      parameters:(NSDictionary *)params
                         success:(BNHTTPClientSuccessBlock)success
                         failure:(BNHTTPClientErrorBlock)failure;

@end
