//
//  BNTestBaseModel.m
//  Pods
//
//  Created by Bambora On Mobile AB on 24/02/2016.
//
//
#import "BNTestModel.h"

@interface BNTestModel ()

@property (nonatomic, copy) NSString *modelId;
@property (nonatomic, assign) NSInteger totalAmount;
@property (nonatomic, assign) BOOL isValid;
@property (nonatomic, copy) BNTestModel *customModel;
@property (nonatomic, strong) NSArray<BNTestModel *> *customModels;

@end

@implementation BNTestModel

+ (NSDictionary *)JSONMappingDictionary {
    return @{
             @"modelId": @"model_id",
             @"totalAmount": @"total_amount",
             @"isValid": @"is_valid",
             @"customModel": @"custom_model",
             @"customModels": @"custom_models"
             };
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError *__autoreleasing *)error {
    self = [super initWithJSONDictionary:JSONDictionary error:error];
    
    if (self) {
        if (self.customModels) {
            NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:[self.customModels count]];
            for(NSDictionary *dict in self.customModels) {
                BNTestModel *test = [[BNTestModel alloc] initWithJSONDictionary:dict error:error];
                [newArray addObject:test];
            }
            self.customModels = newArray;
        }
    }
    
    return self;
}

+ (BNTestModel *)correctMockObject {
    NSError *error;
    return [[BNTestModel alloc] initWithJSONDictionary:[self.class correctJSONDictionary] error:&error];
}

+ (BNTestModel *)missingParamsMockObject {
    NSError *error;
    return [[BNTestModel alloc] initWithJSONDictionary:[self.class missingParamsJSONDictionary] error:&error];
}

+ (BNTestModel *)extraParamsMockObject {
    NSError *error;
    return [[BNTestModel alloc] initWithJSONDictionary:[self.class extraParamsJSONDictionary] error:&error];
}

+ (NSDictionary *)correctJSONDictionary {
    NSDictionary *dict = @{
                           @"model_id" : @"ID0",
                           @"total_amount" : @100,
                           @"is_valid" : @YES,
                           @"custom_model": @{
                                   @"model_id" : @"ID1",
                                   @"total_amount" : @1000,
                                   @"is_valid" : @YES
                                   },
                           @"custom_models": @[@{
                                                   @"model_id" : @"ID4",
                                                   @"total_amount" : @1000,
                                                   @"is_valid" : @YES
                                                 },
                                               @{
                                                   @"model_id" : @"ID5",
                                                   @"total_amount" : @1000,
                                                   @"is_valid" : @YES
                                                 }
                                               ]
                           };
    
    return dict;
}

+ (NSDictionary *)missingParamsJSONDictionary {
    NSDictionary *dict = @{
                           @"model_id" : @"ID0",
                           @"total_amount" : @100,
                           @"custom_model": @{
                                   @"model_id" : @"ID1",
                                   @"is_valid" : @YES
                                   },
                           @"custom_models": @[@{
                                                   @"model_id" : @"ID4",
                                                   @"total_amount" : @1000,
                                                   @"is_valid" : @YES
                                                   },
                                               @{
                                                   @"model_id" : @"ID5",
                                                   @"total_amount" : @1000,
                                                   @"is_valid" : @YES
                                                   }
                                               ]
                           };
    return dict;
}

+ (NSDictionary *)extraParamsJSONDictionary {
    NSDictionary *dict = @{
                           @"model_id" : @"ID0",
                           @"total_amount" : @100,
                           @"is_valid" : @YES,
                           @"extra_param" : @"extraParam",
                           @"custom_model": @{
                                   @"model_id" : @"ID1",
                                   @"total_amount" : @1000,
                                   @"is_valid" : @YES
                                   },
                           @"custom_models": @[@{
                                                   @"model_id" : @"ID4",
                                                   @"total_amount" : @1000,
                                                   @"is_valid" : @YES
                                                   },
                                               @{
                                                   @"model_id" : @"ID5",
                                                   @"total_amount" : @1000,
                                                   @"is_valid" : @YES
                                                   }
                                               ]
                           };
    
    return dict;
}

@end
