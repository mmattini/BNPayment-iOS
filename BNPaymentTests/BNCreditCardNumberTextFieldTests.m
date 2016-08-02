//
//  BNCreditCardNumberTextFieldTests.m
//  BNPayment
//
//  Created by Pierre Le Noan on 2016-08-08.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <BNPayment/BNPayment.h>

@interface BNCreditCardNumberTextFieldTests : XCTestCase

@end

@implementation BNCreditCardNumberTextFieldTests

- (void)testRemoveNonDigits {
    
    BNCreditCardNumberTextField *textField= [BNCreditCardNumberTextField new];
    

    //Given
    NSUInteger cursorPosition =
    [textField offsetFromPosition:textField.beginningOfDocument
                       toPosition:textField.selectedTextRange.start];
    
    NSString *correctValue = @"123123";
    NSString *testString1 = @"1 2 3 123";
    NSString *testString2 = @"12-3 12-3";
    NSString *testString3 = @"1+23 12+3";
    NSString *testString4 = @"123 /123";
    NSString *testString5 = @"12#3 12€3";
    NSString *testString6 = @"123-123";
    NSString *testString7 = @"123_123";
    
    //When
    NSString *digitsRemoved1 = [textField removeNonDigits:testString1 andPreserveCursorPosition:&cursorPosition];
    NSString *digitsRemoved2 = [textField removeNonDigits:testString2 andPreserveCursorPosition:&cursorPosition];
    NSString *digitsRemoved3 = [textField removeNonDigits:testString3 andPreserveCursorPosition:&cursorPosition];
    NSString *digitsRemoved4 = [textField removeNonDigits:testString4 andPreserveCursorPosition:&cursorPosition];
    NSString *digitsRemoved5 = [textField removeNonDigits:testString5 andPreserveCursorPosition:&cursorPosition];
    NSString *digitsRemoved6 = [textField removeNonDigits:testString6 andPreserveCursorPosition:&cursorPosition];
    NSString *digitsRemoved7 = [textField removeNonDigits:testString7 andPreserveCursorPosition:&cursorPosition];

    //Then
    XCTAssertEqualObjects(digitsRemoved1, correctValue);
    XCTAssertEqualObjects(digitsRemoved2, correctValue);
    XCTAssertEqualObjects(digitsRemoved3, correctValue);
    XCTAssertEqualObjects(digitsRemoved4, correctValue);
    XCTAssertEqualObjects(digitsRemoved5, correctValue);
    XCTAssertEqualObjects(digitsRemoved6, correctValue);
    XCTAssertEqualObjects(digitsRemoved7, correctValue);
}


- (void)testAddSpaces {
    
    BNCreditCardNumberTextField *textField= [BNCreditCardNumberTextField new];
    
    
    //Given
    NSUInteger cursorPosition =
    [textField offsetFromPosition:textField.beginningOfDocument
                       toPosition:textField.selectedTextRange.start];
    
    NSString *testString1 = @"1234123412341234";
    NSString *testString2 = @"123412341234";
    NSString *testString3 = @"12341234";
    NSString *testString4 = @"1234123";
    NSString *correctValue1 = @"1234 1234 1234 1234";
    NSString *correctValue2 = @"1234 1234 1234 ";
    NSString *correctValue3 = @"1234 1234 ";
    NSString *correctValue4 = @"1234 123";
    
    //When
    NSString *addSpaces1 = [textField addSpaces:testString1 cursorPosition:&cursorPosition];
    NSString *addSpaces2 = [textField addSpaces:testString2 cursorPosition:&cursorPosition];
    NSString *addSpaces3 = [textField addSpaces:testString3 cursorPosition:&cursorPosition];
    NSString *addSpaces4 = [textField addSpaces:testString4 cursorPosition:&cursorPosition];
    
    //Then
    XCTAssertEqualObjects(addSpaces1, correctValue1);
    XCTAssertEqualObjects(addSpaces2, correctValue2);
    XCTAssertEqualObjects(addSpaces3, correctValue3);
    XCTAssertEqualObjects(addSpaces4, correctValue4);
}

- (void)testAddSpacesAmexDiners {
    
    BNCreditCardNumberTextField *textField= [BNCreditCardNumberTextField new];
    
    
    //Given
    NSUInteger cursorPosition =
    [textField offsetFromPosition:textField.beginningOfDocument
                       toPosition:textField.selectedTextRange.start];
    
    NSString *testString1 = @"123412345612345";
    NSString *testString2 = @"12341234561234";
    NSString *testString3 = @"1234123456";
    NSString *testString4 = @"1234123";
    NSString *correctValue1 = @"1234 123456 12345";
    NSString *correctValue2 = @"1234 123456 1234";
    NSString *correctValue3 = @"1234 123456 ";
    NSString *correctValue4 = @"1234 123";
    
    //When
    NSString *addSpaces1 = [textField addSpacesAmexDiners:testString1 cursorPosition:&cursorPosition];
    NSString *addSpaces2 = [textField addSpacesAmexDiners:testString2 cursorPosition:&cursorPosition];
    NSString *addSpaces3 = [textField addSpacesAmexDiners:testString3 cursorPosition:&cursorPosition];
    NSString *addSpaces4 = [textField addSpacesAmexDiners:testString4 cursorPosition:&cursorPosition];
    
    //Then
    XCTAssertEqualObjects(addSpaces1, correctValue1);
    XCTAssertEqualObjects(addSpaces2, correctValue2);
    XCTAssertEqualObjects(addSpaces3, correctValue3);
    XCTAssertEqualObjects(addSpaces4, correctValue4);
}

@end
