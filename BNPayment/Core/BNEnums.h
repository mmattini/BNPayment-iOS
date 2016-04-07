//
//  Enums.h
//  Pods
//
//  Created by Bambora On Mobile AB on 16/11/2015.
//

/**
 `BNPaymentResult` represents the states of an Payment
 */
typedef enum BNPaymentResult : NSUInteger {
    BNPaymentFailure,                  /** Failed Payment */
    BNPaymentSuccess,                  /** Successful Payment */
    BNPaymentNotAuthorized             /** Not authorized to make Payment */
} BNPaymentResult;

/**
 * An enum indication the reason of the CC registraion completion.
 */
typedef enum : NSUInteger {
    BNCCRegCompletionDone,
    BNCCRegCompletionCancelled,
} BNCCRegCompletion;
