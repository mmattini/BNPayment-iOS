//
//  BNKeyManager.h
//  BNPayment
//
//  Created by Oskar Henriksson on 18/04/2016.
//  Copyright © 2016 Bambora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNKeyUtils : NSObject

/**
 *  A method for getting a reference to the public key for a certificate
 *  of type .cer with a specific filename. The certificate file must be 
 *  present in the bundle provided.
 *
 *  @param filename `NSString` representing the filename of the certificate.
 *  @param bundle   `NSBundle` the bundle containing the certificate file.
 *
 *  @return `SecKeyRef` for the certificate.
 */
+ (SecKeyRef)getPublicKeyRefForCerFile:(NSString *)filename
                                bundle:(NSBundle *)bundle;


/**
 *  A method for getting a reference to the public key for a certificate
 *  of type .pem with a specific filename. The certificate file must be
 *  present in the bundle provided.
 *
 *  @param filename `NSString` representing the filename of the certificate.
 *  @param bundle   `NSBundle` the bundle containing the certificate file.
 *
 *  @return `SecKeyRef` for the certificate.
 */
+ (SecKeyRef)getPublicKeyRefForPemFile:(NSString *)filename
                                bundle:(NSBundle *)bundle;

/**
 *  A method for getting a reference to the public key for a certificate
 *  represented by `NSData`.
 *
 *  @param certData `NSData` representation of the certificate.
 *
 *  @return `SecKeyRef` for the certificate.
 */
+ (SecKeyRef)getPublicKeyRefFromCertData:(NSData *)certData;

/**
 *  A method for getting a reference to the private key of a certificate
 *  of type .p12. The certificate must be present in the bundle provided 
 *  and be named the same as the filename provided.
 *
 *  @param filename `NSString` representing the filename of the certificate.
 *  @param bundle   `NSBundle` the bundle containing the certificate file.
 *  @param password `NSString` the paraphrase for the certificate.
 *
 *  @return `SecKeyRef` for the certificate.
 */
+ (SecKeyRef)getPrivateKeyRefForFile:(NSString *)filename
                              bundle:(NSBundle *)bundle
                        withPassword:(NSString *)password;

@end
