//
//  BNCacheManager.h
//  Pods
//
//  Created by Bambora On Mobile AB on 17/09/2015.
//
//

#import <Foundation/Foundation.h>

/**
 `BNCacheManager` is a handler made to simplify caching objects.
 `BNHandler` offers conveniens methods saving and retrieving objects from disk
 */
@interface BNCacheManager : NSObject

/** Return `BNCacheManager` shared instance creating it if necessary.
 *
 * @return The shared `BNCacheManager` instance
 */
+ (BNCacheManager *)sharedCache;

/**
 *  Saving an object to disk
 *
 *  @param object `NSObject` that will be saved to disk
 *  @param name  `NSString` representing the cache name of the object
 *
 *  @return A `BOOL` indicating the result of the save
 */
- (BOOL)saveObject:(NSObject *)object withName:(NSString *)name;

/**
 *  Retrieving an object from disk
 *
 *  @param name `NSString` representing the cache name of the object
 *
 *  @return `NSCoding` compliant class that has been retrieved from the cache of `nil` if not found
 */
- (id<NSCoding>)getObjectWithName:(NSString *)name;

@end
