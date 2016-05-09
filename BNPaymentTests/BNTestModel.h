//
//  BNTestBaseModel.h
//  Pods
//
//  Created by Bambora On Mobile AB on 24/02/2016.
//
//
#import "BNBaseModel.h"

@interface BNTestModel : BNBaseModel

@property (nonatomic, copy, readonly) NSString *modelId;
@property (nonatomic, assign, readonly) NSInteger totalAmount;
@property (nonatomic, assign, readonly) BOOL isValid;
@property (nonatomic, copy, readonly) BNTestModel *customModel;
@property (nonatomic, strong, readonly) NSArray<BNTestModel *> *customModels;

+ (BNTestModel *)correctMockObject;
+ (BNTestModel *)missingParamsMockObject;
+ (BNTestModel *)extraParamsMockObject;

+ (NSDictionary *)correctJSONDictionary;
+ (NSDictionary *)missingParamsJSONDictionary;
+ (NSDictionary *)extraParamsJSONDictionary;

@end
