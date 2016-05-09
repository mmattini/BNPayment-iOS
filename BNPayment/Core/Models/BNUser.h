//
//  BNUser.h
//  Pods
//
//  Created by Bambora On Mobile AB on 11/01/2016.
//
//

#import "BNBaseModel.h"

/**
 * `BNUser` is a class containing information about the user that you want to register.
 * `BNUser` is provided in the registration API call.
 */
@interface BNUser : BNBaseModel

///------------------------------------------------
/// @name Properties
///------------------------------------------------

/**
*  Add your own reference to the user that you want to register.
*/
@property (strong, nonatomic) NSString *reference;

/**
 *  Add an email to the user.
 */
@property (strong, nonatomic) NSString *email;

/**
 *  Add a phone number to the user.
 */
@property (strong, nonatomic) NSString *phoneNumber;

/**
 *  Add a name to the user.
 */
@property (strong, nonatomic) NSString *name;

@end
