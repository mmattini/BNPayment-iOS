# BNPayment

This library implements credit card registrations and payments using Bambora's backend.

`BNPayment` has only one dependecy: [BNBase library](https://github.com/bambora/BNBase-iOS-internal). This dependency is installed by default when using CocoaPods.


## About

`BNPayment` makes it simple to accept credit card payments in your app. 

Specifically, by integrating `BNPayment` into your project you can make it possible for the users of your app to:

* Register credit cards.

* Make purchases using registered credit cards.

The primary goals of `BNPayment` are:

* Save you time by providing you with an easy-to-use, up-to-date and actively maintained codebase for interacting with the Bambora backend.

* Empower you to do more with less: `BNPayment` has no third-party dependencies.


## Language and Requirements

`BNPayment` is written in Objective-C.

If you're interested in using `BNPayment` in a Swift-based app, please see [iOS Developer Library](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html) for details on how to use Objective-C and Swift together.

**Minimum deployment target:** iOS 8.0


## Installation

Step 0: The project

Create (or use an existing) Xcode project. Open a terminal window and `cd` into the project directory

**Step 1: Install CocoaPods**

We recommend following [this guide](https://guides.cocoapods.org/using/getting-started.html#getting-started) for installing CocoaPods.

**Step 2: Create a Podfile**

Run the following command in the OS X Terminal from the folder where your Xcode project file (`.xcodeproj`) is:

```bash
pod init
```

**Step 3: Edit the Podfile**

Add this information to the Podfile:

```ruby
source 'https://github.com/MobilePaymentSolutionsAB/BMPS-Pod-Spec.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

pod "BNPayment"
```

**Step 4: Install the pod**

Run this command in the OS X Terminal from the same folder as the Podfile:

```bash
pod install
```

Step 5: Re-open project

CocoaPods creates a container workspace for you to use. Close the `.xcodeproj` and open the newly created `.xcworkspace` in Xcode instead.

<a name="setup"></a>
## Setup

***Get an API token***

An API token is required in order to communicate with Bambora's backend through the SDK.

The API token has two purposes: 
* It identifies you as a merchant.
* It determines whether the SDK should be connected to the test environment or to the production environment. Each environment requires a separate API token.

After signing up for a SDK developer account, you will receive an API token for the test environment. You can then decide to apply for an API token for the production environment.

*Todo: Add link to sign up page.*

***Import the SDK***

This import statement needs to be added to any implementation (.m) file that needs access to the SDK (including the AppDelegate):

```objective-c
#import <BNPayment/BNPayment.h>
```

***Configure the AppDelegate***

Run the following setup method upon initialization of your app. It is recommended to do this in `‑ application:didFinishLaunchingWithOptions:`

```objective-c
NSString *apiToken = <API_TOKEN>; // Required: Sign up is required to obtain API tokens.
NSString *myBaseURL = <CUSTOM_URL>; // Optional: Overrides the default base URL for the API.
BOOL debugSetting = <DEBUG_SETTING>; // Optional: Enables logging in Xcode when set to YES.
NSError *error;

[BNHandler setupWithApiToken:apiToken baseUrl:myBaseURL debug:debugSetting error:&error];
```

## Payments

To make a payment, two intermediate steps are required.

1. [User Registration](#userregistration)

2. [Credit Card Registration](#creditcardregistration)

After both are completed successfully, the Library will allow you to [make payments](#makingpayments) quickly using only one API call

<a name="userregistration"></a>
## User Registration

You can use `BNPayment` to register a user directly from the mobile device, by doing this:

```objective-c
if (![[BNHandler sharedInstance] isRegistered]) {
    
    // Optionals parameters:
    BNUser *userObject = [BNUser new];
    userObject.name = <NAME>;
    userObject.email = <EMAIL>;
    userObject.phoneNumber = <PHONE_NUMBER>;
    userObject.reference = <CUSTOM_REFERENCE>;
    
    [[BNHandler sharedInstance] registerUser:userObject completion:^(BOOL success) {
        // Registration succeeded.
    }];  
}
```

Alternatively, you can use the Bambora backend to register a user from your backend instead. In this case your backend will have a `BNAuthenticator` object representing each user in the form of a `uuid` and `sharedSecret`.

To use such an object with `BNPayment`:

```objective-c
if (![[BNHandler sharedInstance] isRegistered]) {

    BNAuthenticator *authenticator = [BNAuthenticator new];

    authenticator.sharedSecret = <SECRET_SENT_FROM_YOUR_BACKEND>;
    authenticator.uuid = <UUID_SENT_FROM_YOUR_BACKEND>;

    [[BNHandler sharedInstance] registerAuthenticator:authenticator];
}
```

<a name="creditcardregistration"></a>
## Credit Card Registration

**Make sure you've successfully [set up BNPayments](#setup) and have a [valid user session](#userregistration) before continuing with this step.**

Credit card registration is done through a secure web-based registration form, called a hosted form, that you can easily include in your app.

***How to accept credit card registrations***

The view controller of class `BNCCHostedRegistrationFormVC` is used to authorize and saved credit cards.
All you need to do is initialize an instance and set its callback block, then present the view controller. 

Here's an example of how to use `BNCCHostedRegistrationFormVC` form within a navigation controller:

```objective-c
#import <BNPayment/BNPayment.h>

// (...)

__weak BNViewController *weakSelf = self;

// Create the view controller for the hosted form:
BNCCHostedRegistrationFormVC *ccRegistrationVC = 
    [[BNCCHostedRegistrationFormVC alloc] initWithHostedFormParams:<CUSTOM_HOSTED_FORM_SETTINGS>];
    /* Instructions for creating an object with <CUSTOM_HOSTED_FORM_SETTINGS> can found further down 
    under "Customize the credit card registration view" */

// Display the credit card registration view:
[self.navigationController pushViewController:ccRegistrationVC animated:YES];

ccRegistrationVC.completionBlock = ^(BNCCRegCompletion completion) {

        if (completion == BNCCRegCompletionDone) {
            // Credit card registration successful. Dismiss the hosted form:
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else if (completion == BNCCRegCompletionCancelled) {
            // The credit card registration process was cancelled.
        }

};
```

***Customization of `BNCCHostedRegistrationFormVC`***

You can customize a view controller instance in three ways:

1) set a custom header view and a custom footer view for the credit card registration view if you wish:

```objective-c
[ccRegistrationVC addHeaderView:<HEADER_VIEW>]; // Set a custom header view
[ccRegistrationVC addFooterView:<FOOTER_VIEW>]; // Set a custom footer view
```

2) Modify the text used in the form using custom placeholders through the `BNCCHostedFormParams` interface.

3) Use a custom CSS file to change the look and feel of the form [(here's an example)](http://ci.mobivending.com/CNP/example.css) through the `BNCCHostedFormParams` interface.

***Managing credit cards***

When a credit card is registered using `BNCCHostedRegistrationFormVC`, a tokenized card id is saved on the device.

Here are some useful ways of working with credit cards:

```objective-c
#import <BNPayment/BNPayment.h>

// (...)

// Get a list of all registered credit cards
NSArray<BNAuthorizedCreditCard *> *registeredCards = [[BNPaymentHandler sharedInstance] authorizedCards];

// Check if any credit card token has been registered:
if (registeredCards.count > 0) {
    // One or more credit cards have been registered in the app
}

// Get a specific registered credit card (in this case, the first one in the list):
BNAuthorizedCreditCard *creditCard = [registeredCards firstObject];

// Remove a registered credit card from the device:
BNPaymentHandler *paymentHandler = [BNPaymentHandler sharedInstance];
[paymentHandler removeAuthorizedCreditCard:creditCard];

```

<a name="makingpayments"></a>
## Making payments

**Note: you need to complete the following before making payments**

1. [User Registration](#userregistration)

2. [Credit Card Registration](#creditcardregistration)

Making a payment is as simple as filling in a `BNPaymentParams` instance:

```objective-c
// Get a list of all authorized credit card tokens
NSArray<BNAuthorizedCreditCard *> *registeredCards = [[BNPaymentHandler sharedInstance] authorizedCards];

// Get a specific registered credit card (in this case, the first one in the list):
BNAuthorizedCreditCard *creditCard = [registeredCards objectAtIndex:0];

BNPaymentParams *paymentSettings = [BNPaymentParams new];
paymentSettings.currency = <CURRENCY>; // A currency code in ISO-4217 format.
paymentSettings.amount = <AMOUNT>; // Payment amount expressed in cents.
paymentSettings.token = creditCard.creditCardRecurringPaymentId;
paymentSettings.comment = <COMMENT>; // Comment about the payment

// An example of how to create a random payment identifier:
NSString *paymentIdentifier = [NSString stringWithFormat:@"%u", arc4random_uniform(INT_MAX)];

// This function makes the payment based on the above settings and then returns a result.    
[[BNPaymentHandler sharedInstance] 
    makePaymentWithPaymentParams:paymentSettings
        identifier:paymentIdentifier
            result:^(BNPaymentResult result) {
                if (result == BNPaymentSuccess) {
                    // Payment succeeded
                } else {
                      // Payment failed
                  }
            }];
}
```

## Author

[Bambora On Mobile AB](http://www.bambora.com/en/bambora-on-mobile/)

## Contact info

We welcome questions and feedback - you can reach us by sending an e-mail to [sdk@bambora.com](mailto:sdk@bambora.com)

## License

`BNPayment` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
