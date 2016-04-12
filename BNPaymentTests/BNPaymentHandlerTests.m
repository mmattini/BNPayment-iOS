//
//  BNPaymentHandlerTests.m
//  BNPayment
//
//  Created by Bambora On Mobile AB on 23/02/2016.
//  Copyright © 2016 Bambora On Mobile AB. All rights reserved.
//

@interface BNPaymentHandlerTests : XCTestCase

@end

@implementation BNPaymentHandlerTests {
    BNAuthorizedCreditCard *firstCard;
    BNAuthorizedCreditCard *firstCardDuplicate;
    BNAuthorizedCreditCard *secondCard;
    BNAuthorizedCreditCard *thirdCard;
    BNPaymentHandler *handler;
}

- (void)setUp {
    [super setUp];

    handler = [BNPaymentHandler sharedInstance];
    
    firstCard = [BNAuthorizedCreditCard new];
    firstCard.creditCardAlias = @"First";
    firstCard.creditCardToken = @"123";
    
    firstCardDuplicate = [BNAuthorizedCreditCard new];
    firstCardDuplicate.creditCardAlias = @"First card ducplicate";
    firstCardDuplicate.creditCardToken = @"123";
    
    secondCard = [BNAuthorizedCreditCard new];
    secondCard.creditCardAlias = @"Second";
    secondCard.creditCardToken = @"1234";
    
    thirdCard = [BNAuthorizedCreditCard new];
    thirdCard.creditCardAlias = @"Third";
    thirdCard.creditCardToken = @"1235";
}

- (void)testSavingCards {
    XCTAssertFalse([[handler authorizedCards] containsObject:firstCard], "Does not contains first card");
    XCTAssertFalse([[handler authorizedCards] containsObject:secondCard], "Does not contains second card");
    
    [handler saveAuthorizedCreditCard:firstCard];
    [handler saveAuthorizedCreditCard:secondCard];

    XCTAssertTrue([[handler authorizedCards] containsObject:firstCard], "Containts first card");
    XCTAssertTrue([[handler authorizedCards] containsObject:secondCard], "Containts second card");
}

- (void)testSavingDuplicates {
    XCTAssertFalse([[handler authorizedCards] containsObject:firstCard], "Does not contains first card");
    
    [handler saveAuthorizedCreditCard:firstCard];
    NSUInteger countAfterAddingOneCard = [[handler authorizedCards] count];
    [handler saveAuthorizedCreditCard:firstCard];
    
    XCTAssertEqual(countAfterAddingOneCard, [handler authorizedCards].count, "Should have same count after adding duplicate");
}

- (void)testSavingDifferentCardsWithSameId {
    XCTAssertFalse([[handler authorizedCards] containsObject:firstCard], "Does not contains first card");
    XCTAssertFalse([[handler authorizedCards] containsObject:firstCardDuplicate], "Does not contains first card duplicate");
    
    [handler saveAuthorizedCreditCard:firstCard];
    NSUInteger countAfterAddingOneCard = [[handler authorizedCards] count];
    [handler saveAuthorizedCreditCard:firstCardDuplicate];
    
    XCTAssertEqual(countAfterAddingOneCard, [handler authorizedCards].count, "Should have same count after adding duplicate");
}

- (void)testRemovingCards {
    XCTAssertFalse([[handler authorizedCards] containsObject:firstCard], "Does not contains first card");
    XCTAssertFalse([[handler authorizedCards] containsObject:secondCard], "Does not contains second card");
    XCTAssertFalse([[handler authorizedCards] containsObject:thirdCard], "Does not contains third card");

    [handler saveAuthorizedCreditCard:firstCard];
    [handler saveAuthorizedCreditCard:secondCard];
    [handler saveAuthorizedCreditCard:thirdCard];
    
    XCTAssertTrue([[handler authorizedCards] containsObject:firstCard], "Does contains first card");
    XCTAssertTrue([[handler authorizedCards] containsObject:secondCard], "Does contains second card");
    XCTAssertTrue([[handler authorizedCards] containsObject:thirdCard], "Does contains third card");
    
    [handler removeAuthorizedCreditCard:firstCard];
    [handler removeAuthorizedCreditCard:thirdCard];
    
    XCTAssertFalse([[handler authorizedCards] containsObject:firstCard], "Does not contains first card");
    XCTAssertTrue([[handler authorizedCards] containsObject:secondCard], "Does contains second card");
    XCTAssertFalse([[handler authorizedCards] containsObject:thirdCard], "Does not contains third card");
}

- (void)tearDown {
    [super tearDown];
    
    [handler removeAuthorizedCreditCard:firstCard];
    [handler removeAuthorizedCreditCard:secondCard];
    [handler removeAuthorizedCreditCard:thirdCard];
}

@end