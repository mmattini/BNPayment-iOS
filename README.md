# BNPayment

This library implements credit card registrations and payments using Bambora's backend.

## About

`BNPayment` makes it simple to accept credit card payments in your app. 

Specifically, by integrating `BNPayment` into your project you can make it possible for the users of your app to:

* Register credit cards.

* Make purchases using registered credit cards.

**Goals**

The primary goals of `BNPayment` are to:

* Save you time by providing you with an easy-to-use, up-to-date and actively maintained codebase for interacting with the Bambora backend.

* Empower you to do more with less: `BNPayment` has no third-party dependencies.

**How it works**

This is a brief overview of how what the SDK does:

***Setup and authentication***

Initially, the SDK connects to the SDK backend and sends in an API token. Based on that API token, the SDK backend then identifies and authorizes the SDK. The SDK then registers itself with the SDK backend. After these steps, credit card registration and payment functionality is enabled in the app.

***Credit card registration***

The user needs to register his/her credit card in the app in order to make a purchase. Credit card registration is done through a secure web-based form, which we refer to as a Hosted Payment Page (HPP). The HPP is opened in a web view in the app and the user then registers his/her credit card on it.

After a successful registration, the HPP will return a card token which is automatically saved locally in the app. The card token is a tokenized version of the credit card and can be used by he SDK in order to make payments with the card in question.

The developer can use callback methods to manage the HPP and to get the card token after a successful credit card registration.

The SDK supports multiple credit card registrations.

***Payments***

When a valid credit card that contains sufficient funds has been registered through the SDK, payments can be made.

This is done by making a call to the SDK backend that includes the amount, currency and card token.

When an SDK payment is successful, the payment amount becomes reserved in the customer's bank account. It is then up to you as a merchant to capture/withdraw the payment from the customer's bank account (which can be done either through the merchant backend interface or by making an API integration with the SDK backend).

## Language and Requirements

`BNPayment` is written in Objective-C.

If you're interested in using `BNPayment` in a Swift-based app, please see [iOS Developer Library](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html) for details on how to use Objective-C and Swift together.

**Minimum deployment target:** iOS 8.0


## Installation

To install BNPayment, we recommend using either CocoaPods or Carthage.

#### How to install via CocoaPods

CocoaPods is a dependency manager for third-party libraries.

**Step 1: Create or select an Xcode project**

Create (or use an existing) Xcode project. Open a terminal window and `cd` into the project directory

**Step 2: Install CocoaPods**

We recommend following [this guide](https://guides.cocoapods.org/using/getting-started.html#getting-started) for installing CocoaPods.

**Step 3: Create a Podfile**

Run the following command in the OS X Terminal from the folder where your Xcode project file (`.xcodeproj`) is:

```bash
pod init
```

**Step 4: Edit the Podfile**

Add this information to the Podfile:

```ruby
source 'https://github.com/MobilePaymentSolutionsAB/BMPS-Pod-Spec.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

pod "BNPayment"
```

**Step 5: Install the pod**

Run this command in the OS X Terminal from the same folder as the Podfile:

```bash
pod install
```

**Step 6: Re-open the project**

CocoaPods creates a container workspace for you to use. Close the `.xcodeproj` and open the newly created `.xcworkspace` in Xcode instead.

#### How to install via Carthage

Carthage is a is a dependency manager for third-party libraries.

**Step 1: Create or select an Xcode project**

Create (or use an existing) Xcode project. Open a terminal window and `cd` into the project directory

**Step 2: Install Carthage**

We recommend following [these instructions](https://github.com/Carthage/Carthage#installing-carthage) for installing Carthage.

**Step 3: Create a Cartfile**

Run the following command in the OS X Terminal from the folder where your Xcode project file (`.xcodeproj`) is:

```bash
touch Cartfile
```

Open the newly created Cartfile in the text editor of your choice, and enter the following text:

```
github "bambora/BNPayment-iOS-internal" "develop"
```

**Step 4: Create the framework file**

Run the following command in the OS X Terminal:

```bash
carthage update
```

This will create a file called BNPayment.framework that you can find by going to Carthage/Build/iOS.

**Step 5: Add the framework to your Xcode project**

The following instructions apply to Xcode 7.3:

Open your project in Xcode.

Go to Target -> General -> Linked Frameworks and Libraries

Add BNPayment.framework to the list.

Go to Build Phase and add a New Run Script Phase and then enter the following script line: 

```bash
/usr/local/bin/carthage copy-frameworks 
```

Add the following line under Input Files: 

```
$(SRCROOT)/Carthage/Build/iOS/BNPayment.framework
```

<a name="setup"></a>
## Setup

***Get an API token***

An API token is required in order to communicate with Bambora's backend through the SDK.

The API token has two purposes: 
* It identifies you as a merchant.
* It determines whether the SDK should be connected to the test environment or to the production environment. Each environment requires a separate API token.

After signing up for a SDK developer account, you will receive an API token for the test environment. You can then decide to apply for an API token for the production environment.

***Import the SDK***

This import statement needs to be added to any implementation (.m) file that needs access to the SDK (including the AppDelegate):

```objective-c
#import <BNPayment/BNPayment.h>
```

<a name="configureappdelegate"></a>
***Configure the AppDelegate***

Run the following setup method upon initialization of your app. It is recommended to do this in the `‑ application:didFinishLaunchingWithOptions:` method in AppDelegate.m.

```objective-c
NSError *error;
[BNPaymentHandler setupWithApiToken:@"<API_TOKEN>" // Required.
                            baseUrl:nil // Optional. Overrides the URL to the SDK backend.
                              debug:NO // Optional. Enables logging in Xcode when set to YES.
                              error:&error];
```

A couple of notes regarding the example above:
* If you provide a test API token, the SDK will enter test mode. If you provide a production API token, the SDK will enter production mode. 
* The debug setting should be set to NO in live applications.

<a name="creditcardregistration"></a>
## Credit Card Registration

*Make sure you've successfully [set up BNPayments](#setup) before continuing with this step.*

***How to accept credit card registrations***

Credit card registration is done through a secure web-based registration form, also known as a Hosted Payment Page, that you can easily include in your app through the view controller of class `BNCCHostedRegistrationFormVC`.

Here's an example of how to use `BNCCHostedRegistrationFormVC` within a navigation controller:

```objective-c
__weak UIViewController *weakSelf = self;

// Create the view controller for the hosted form:
BNCCHostedRegistrationFormVC *ccHostedRegistrationVC = 
    [[BNCCHostedRegistrationFormVC alloc] initWithHostedFormParams:<CUSTOM_HOSTED_FORM_SETTINGS>];
    /* Instructions for creating an object with <CUSTOM_HOSTED_FORM_SETTINGS> can found further down 
    under "How to customize the Hosted Payment Page" */

// Display the credit card registration view:
[self.navigationController pushViewController:ccHostedRegistrationVC animated:YES];
```

Use these callback methods for responding to operations:

```objective-c

- (void)BNPaymentWebview:(BNPaymentWebview *)webview didStartOperation:(BNPaymentWebviewOperation)operation {
  // Lets you know that an operation (such as loading the hosted payment page) has started.
}

- (void)BNPaymentWebview:(BNPaymentWebview *)webview didFinishOperation:(BNPaymentWebviewOperation)operation {
  // Lets you know when an operation (such as loading the hosted payment page) has finished.
}

- (void)BNPaymentWebview:(BNPaymentWebview *)webview didRegisterAuthorizedCard:(BNAuthorizedCreditCard *)authorizedCard {
  /* Lets you know that a credit card registration attempt succeeded. 
  This method Also lets you access the card token (through authorizedCard). */
}

- (void)BNPaymentWebview:(BNPaymentWebview *)webview didFailOperation:(BNPaymentWebviewOperation)operation withError:(NSError *)error {
   // Lets you know that a credit card registration attempt failed.
}
```

***How to customize the Hosted Payment Page***

You can customize a `BNCCHostedRegistrationFormVC` instance in these ways:

Set a custom header view and a custom footer view::

```objective-c
ccHostedRegistrationVC.webviewDelegate = self;
[ccHostedRegistrationVC addHeaderView:<HEADER_VIEW>]; // Set a custom header view
[ccHostedRegistrationVC addFooterView:<FOOTER_VIEW>]; // Set a custom footer view
```

Specify a custom CSS file to change the look and feel of the Hosted Payment Page and specify the text to be used on the page:

```objective-c
BNCCHostedFormParams customizationSettings = [BNCCHostedFormParams hostedFormParamsWithCSS:@"<CSS_URL>"
                                                                     cardNumberPlaceholder:@"Card number"
                                                                         expiryPlaceholder:@"Expiration"
                                                                            cvvPlaceholder:@"CVV"
                                                                                submitText:@"Submit"];

BNCCHostedRegistrationFormVC *ccHostedRegistrationVC = 
  [[BNCCHostedRegistrationFormVC alloc] initWithHostedFormParams:[BNCCHostedFormParams customizationSettings]];
```

Here is a CSS example:

```css
body {
    margin-top: 0pt;
    padding: 0pt;
}

form{
    width: 100%;
}

#container {
    padding-top: 10pt;
}

.cardnumber {
    width: 100%;
}

.expiry {
    float: left;
    width: 50%;
}

.expiry input {
    border-top: 0pt;
    border-right: 0.5pt solid #dcddde;
}

.cvc {
    float: right;
    width: 50%;
}

.cvc input {
    border-top: 0pt;
    border-left: 0.5pt solid #dcddde;
}

.input-group {
    margin-bottom: 0pt;
    padding: 0pt;
}

[type=submit] {
    width: 100%;
    font-size: 12pt;
    color: white;
    background-color: #40245f;
    height: 36pt;
    margin-top: 5pt;
    border: 0px;
    border-radius: 0pt;
}

input {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    -moz-tap-highlight-color: rgba(0,0,0,0);
    tap-highlight-color: rgba(0,0,0,0);
    
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    
    color: #4f5355;
    font-size: 10pt;
    box-sizing: border-box;
    width: 100%;
    height: 30pt;
    border-radius: 1px;
    border: 1pt solid #dcddde;
    padding-left: 10pt;
    padding-right: 10pt;
}

input:focus {
    border-bottom: 1pt solid #8c9091;
}

.invalid {
    border-bottom: 1px solid red;
}

```

***Managing credit cards***

When a credit card is registered using `BNCCHostedRegistrationFormVC`, a tokenized card id is saved on the device.

Here are some useful ways of working with credit cards:

```objective-c
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

*Make sure you've successfully [set up BNPayments](#setup) and implemented [Credit Card Registration](#creditcardregistration) before continuing with this step.*

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

<a name="testmode"></a>
## Test mode

***Test mode vs Production mode***

The SDK can be used in one of two modes:

* Test mode allows you to register test cards and make test payments using those cards. Real credit cards cannot be registered in test mode.
* Production mode allows the user to register real credit cards and to make real payments using those cards. Test credit cards cannot be used in production mode.

***How to switch between test and production mode***

To enable test mode, you need to use a test API token as the initial parameter in the setupWithApiToken: method of the BNHandler class.

To enable production mode, you need to provide a production API token as the initial parameter in the setupWithApiToken: method of the BNHandler class.

You can find a code example in the above section [Configure the AppDelegate](#configureappdelegate).

***Test credit cards***

You can use the following test credit cards for testing registration and purchasing when the SDK is running in test mode (no real money is charged when these test cards are used):

```
VISA (Sweden)
Card number: 4002 6200 0000 0005
Expiration (month/year): 05/17
CVC: 000
```

```
MasterCard (Sweden)
Card number: 5125 8600 0000 0006
Expiration (month/year): 05/17
CVC: 000
```

```
VISA (Norway)
Card number: 4002 7700 0000 0008
Expiration (month/year): 05/17
CVC: 000
```

```
MasterCard (Norway)
Card number: 5206 8300 0000 0001
Expiration (month/year): 05/17
CVC: 000
```
## Author

[Bambora On Mobile AB](http://www.bambora.com/en/bambora-on-mobile/)

## Contact info

We welcome questions and feedback - you can reach us by sending an e-mail to [sdk@bambora.com](mailto:sdk@bambora.com)

## License

`BNPayment` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
