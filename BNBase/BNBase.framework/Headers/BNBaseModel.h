//
//  BNBaseModel.h
//  Pods
//
//  Created by Bambora On Mobile AB on 24/02/2016.
//
//

#import <Foundation/Foundation.h>

@interface BNBaseModel : NSObject <NSCoding, NSCopying>

+ (NSDictionary *)JSONMappingDictionary;

- (instancetype)initWithJSONDictionary:(NSDictionary *)JSONDictionary
                                 error:(NSError **)error;

- (NSDictionary *)JSONDictionary;

@end
