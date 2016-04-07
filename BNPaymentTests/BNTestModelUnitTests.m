//
//  BNTestModelUnitTests.m
//  Copyright (c) 2016 Bambora ( http://bambora.com/ )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "BNTestModel.h"
#import "BNPayment.h"

@import XCTest;

@interface BNTestModelUnitTests : XCTestCase

@end

@implementation BNTestModelUnitTests


- (void)testInitWithJSONDict {
    BNTestModel *testModel = [BNTestModel correctMockObject];

    XCTAssertNotNil(testModel, "Test model not nil");
    XCTAssertTrue([testModel isKindOfClass:[BNTestModel class]], "Test model is kind of class BNTestModel");
    XCTAssertEqualObjects(testModel.modelId, @"ID0", "Correct modelID property");
    XCTAssertEqual(testModel.totalAmount, 100, "Correct totalAmount property");
    XCTAssertTrue(testModel.isValid, "Correct isValid property");
    XCTAssertTrue([testModel.customModel isKindOfClass:[BNTestModel class]], "customModel property is kind of class BNTestModel");
}

- (void)testInitWithJSONDictExtraParams {
    BNTestModel *testModel = [BNTestModel extraParamsMockObject];
    
    XCTAssertNotNil(testModel, "Test model not nil");
    XCTAssertTrue([testModel isKindOfClass:[BNTestModel class]], "Test model is kind of class BNTestModel");
    XCTAssertEqualObjects(testModel.modelId, @"ID0", "Correct modelID property");
    XCTAssertEqual(testModel.totalAmount, 100, "Correct totalAmount property");
    XCTAssertTrue(testModel.isValid, "Correct isValid property");
    XCTAssertTrue([testModel.customModel isKindOfClass:[BNTestModel class]], "customModel property is kind of class BNTestModel");
}

- (void)testInitWithNilDictionary {
    NSError *error;
    BNTestModel *testModel = [[BNTestModel alloc] initWithJSONDictionary:nil error:&error];
    
    XCTAssertNil(error);
    XCTAssertNotNil(testModel, "Test model not nil");
    XCTAssertTrue([testModel isKindOfClass:[BNTestModel class]], "Test model is kind of class BNTestModel");
    XCTAssertNil(testModel.modelId, "Correct modelID property");
    XCTAssertEqual(testModel.totalAmount, 0, "Correct totalAmount property");
    XCTAssertFalse(testModel.isValid, "Correct isValid property");
    XCTAssertNil(testModel.customModel, "customModel propert is nil");
}

- (void)testInitiWithJSONDictMissingParams {
    BNTestModel *testModel = [BNTestModel missingParamsMockObject];
    
    XCTAssertNotNil(testModel, "Test model not nil");
    XCTAssertTrue([testModel isKindOfClass:[BNTestModel class]], "Test model is kind of class BNTestModel");
    XCTAssertEqualObjects(testModel.modelId, @"ID0", "Correct modelID property");
    XCTAssertEqual(testModel.totalAmount, 100, "Correct totalAmount property");
    XCTAssertFalse(testModel.isValid, "Correct isValid property");
    XCTAssertTrue([testModel.customModel isKindOfClass:[BNTestModel class]], "customModel property is kind of class BNTestModel");
}

- (void)testGenerateNSDictionaryWithJSONMappingFormat {
    BNTestModel *testModel = [BNTestModel correctMockObject];
    
    NSDictionary *correctDict = [BNTestModel correctJSONDictionary];
    NSDictionary *dictToTest = [testModel JSONDictionary];
    
    XCTAssertEqualObjects(correctDict, dictToTest, "Should generate a NSDictionary in accordance with the JSONMappingDictionary format");
}

- (void)testIsEqualMethod {
    BNTestModel *firstMockedModel = [BNTestModel correctMockObject];
    BNTestModel *secongMockedModel = [BNTestModel correctMockObject];

    XCTAssertEqualObjects(firstMockedModel, secongMockedModel, "Should say two objects with the same values is equal");
}

- (void)testCopyMethod {
    BNTestModel *correctModel = [BNTestModel correctMockObject];
    BNTestModel *modelToTest = [correctModel copy];
    
    XCTAssertEqualObjects(correctModel, modelToTest, "Should make a complete copy when copy method is called");
}

- (void)testSerialization {
    BNCacheManager *sharedCache = [BNCacheManager sharedCache];
    BNTestModel *testModel = [BNTestModel correctMockObject];
    
    [sharedCache saveObject:testModel withName:@"testObject"];
    
    BNTestModel *decodedObject = (BNTestModel *)[sharedCache getObjectWithName:@"testObject"];
    XCTAssertNotNil(decodedObject, "Decoded object not nil");
    XCTAssertEqualObjects(testModel, decodedObject, "Decoded object and initial object is equal");
}

@end