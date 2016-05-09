//
//  BNBaseModel.m
//  Pods
//
//  Created by Bambora On Mobile AB on 24/02/2016.
//
//

#import "BNBaseModel.h"
#import <objc/runtime.h>

@implementation BNBaseModel

+ (NSDictionary *)JSONMappingDictionary {
    return nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)JSONDictionary
                                 error:(NSError **)error {
    self = [super init];
    
    if (![JSONDictionary isKindOfClass:[NSDictionary class]]) {
        return self;
    }
    
    if (self) {
        NSDictionary *JSONMappingDictionary = [self.class JSONMappingDictionary];
        
        [JSONMappingDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,
                                                                   id  _Nonnull obj,
                                                                   BOOL * _Nonnull stop) {
            Class classForKey = [self classOfPropertyNamed:key];
            
            NSString *JSONKey = JSONMappingDictionary[key];
            id JSONObject = JSONDictionary[JSONKey];
            
            if ([classForKey isSubclassOfClass:[BNBaseModel class]] && [JSONObject isKindOfClass:[NSDictionary class]]) {
                JSONObject = [[(BNBaseModel *)[classForKey alloc] init] initWithJSONDictionary:JSONObject error:error];
            }
            
            if (JSONObject && JSONKey) {
                [self setValue:JSONObject forKey:key];
            }
            
        }];
    }
    
    return self;
}

- (NSDictionary *)JSONDictionary {
    NSDictionary *JSONMappingDictionary = [self.class JSONMappingDictionary];

    NSMutableDictionary *JSONDictionary = [[NSMutableDictionary alloc] initWithCapacity:[[JSONMappingDictionary allKeys] count]];
    
    [JSONMappingDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,
                                                               id  _Nonnull obj,
                                                               BOOL * _Nonnull stop) {
        NSString *JSONKey = JSONMappingDictionary[key];
        
        id object = [self valueForKey:key];
     
        if ([object respondsToSelector:@selector(JSONDictionary)]) {
            object = [(BNBaseModel *)object JSONDictionary];
        }
        
        if ([object isKindOfClass:[NSArray class]]) {
            NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:[((NSArray *)object) count]];
            for(id arrayObject in object) {
                if ([arrayObject respondsToSelector:@selector(JSONDictionary)]) {
                    [newArray addObject:[(BNBaseModel *)arrayObject JSONDictionary]];
                }
            }
            object = newArray;
        }
        
        if (object) {
            [JSONDictionary setValue:object forKey:JSONKey];
        }
    }];
    
    return JSONDictionary;
}

#pragma mark - Coding

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (self == nil) return nil;
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for(int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        
        NSString *key = @(property_getName(property));
        
        id object = [decoder decodeObjectForKey:key];
        
        if (object) {
            [self setValue:object forKey:key];
        }
    }
    
    free(properties);
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    unsigned int count;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for(int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        
        NSString *key = @(property_getName(property));
        id object = [self valueForKey:key];
        
        if (object) {
            [encoder encodeObject:object forKey:key];
        }
    }
    
    free(properties);
}

#pragma mark - Copying

- (instancetype)copyWithZone:(NSZone *)zone {
    BNBaseModel *copy = [[self.class allocWithZone:zone] init];

    [[self.class JSONMappingDictionary] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,
                                                                            id  _Nonnull obj,
                                                                            BOOL * _Nonnull stop) {
        id object = [self valueForKey:key];
        
        if (object) {
            [copy setValue:object forKey:key];
        }
    }];
    
    return copy;
}

#pragma mark - Private methods

-(Class)classOfPropertyNamed:(NSString*)propertyName {

    Class propertyClass;
    
    objc_property_t property = class_getProperty([self class], [propertyName UTF8String]);
    NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@","];
    
    if (splitPropertyAttributes.count > 0) {
        NSString *encodeType = splitPropertyAttributes[0];
        NSArray *splitEncodeType = [encodeType componentsSeparatedByString:@"\""];
        
        if (splitEncodeType.count > 1) {
            NSString *className = splitEncodeType[1];
            propertyClass = NSClassFromString(className);
        }
    }
    
    return propertyClass;
}

#pragma mark - NSObject

- (NSString *)description {
    return [self JSONDictionary].description;
}

- (NSUInteger)hash {
    __block NSUInteger value = 0;
    
    NSDictionary *JSONMappingDictionary = [self.class JSONMappingDictionary];
    [JSONMappingDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,
                                                               id  _Nonnull obj,
                                                               BOOL * _Nonnull stop) {
        value ^= [[self valueForKey:key] hash];
    }];
    
    return value;
}

- (BOOL)isEqual:(BNBaseModel *)model {
    if (self == model) return YES;
    if (![model isKindOfClass:self.class]) return NO;
    
    __block BOOL isEqual = YES;
    
    NSDictionary *JSONMappingDictionary = [self.class JSONMappingDictionary];
    [JSONMappingDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,
                                                               id  _Nonnull obj,
                                                               BOOL * _Nonnull stop) {
        id modelValue = [model valueForKey:key];
        id objectValue = [self valueForKey:key];
        
        BOOL equalValue = [modelValue isEqual:objectValue] || (!modelValue && !objectValue);
        
        if (!equalValue) {
            isEqual = NO;
            *stop = YES;
        }
    }];
    
    return isEqual;
}

@end
