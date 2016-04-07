//
//  BNFormModel.m
//  Pods
//
//  Created by Bambora On Mobile AB on 14/01/2016.
//
//

#import "BNFormModel.h"
#import "BNFormInputModel.h"

@implementation BNFormModel

- (NSDictionary *)generateFormDictionary {
    NSMutableDictionary *formDict = [NSMutableDictionary new];
    
    for(BNFormInputModel *formModel in _models) {
        if (formModel.mappingKey && formModel.value) {
            formDict[formModel.mappingKey] = formModel.value;
        }
    }
    
    return formDict;
}

@end
