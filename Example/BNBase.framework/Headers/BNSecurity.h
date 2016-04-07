//
//  BNNetworkSecurity.h
//  Pods
//
//  Created by Bambora On Mobile AB on 09/03/2016.
//
//

#import <Foundation/Foundation.h>

@interface BNSecurity : NSObject

/**
*  This method can be used to respond to a connection level authentication challenge.
*  This method uses the pinned certs of the bundle to verify against.
*
*  @param serverTrust The X.509 certificate trust of the server.
*  @param domain      The domain to be verified. Must not be `nil`.
*
*  @return If the server should be trusted or not.
*/
- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(NSString *)domain;

/**
 *  This method is used to determine whether or not the certificate trust is signed by the master X.509 cert.
 *
 *  @param secTrust The X.509 certificate trust of the cert to be verified.
 *
 *  @return If the certificate is signed by the master cert.
 */
- (BOOL)evaluateCertTrustAgainstMasterCert:(SecTrustRef)secTrust;

/**
 *  This method is used for overriding the pinned certs.
 *  Note that overriding the pinned certs with `nil` or empty `NSArray` will result in trust evaluation always failing.
 *
 *  @param certs `NSArray` containing X.509 certs.
 */
- (void)overridePinnedCerts:(NSArray<NSData *> *)certs;

@end
