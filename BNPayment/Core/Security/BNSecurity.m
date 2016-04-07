//
//  BNNetworkSecurity.m
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


#import "BNSecurity.h"

@interface BNSecurity ()

@property (nonatomic, strong) NSArray *pinnedCertificates;

@end

@implementation BNSecurity

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.pinnedCertificates = [self getPinnedCertificates];
    }
    
    return self;
}

#pragma mark - Public methods

- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(NSString *)domain {
    
    if (!self.pinnedCertificates || !domain || [self.pinnedCertificates count] == 0) {
        return NO;
    }
    
    NSArray *securityPolicies = @[CFBridgingRelease(SecPolicyCreateSSL(true, (__bridge CFStringRef)domain))];
    SecTrustSetPolicies(serverTrust, (__bridge CFArrayRef)(securityPolicies));
    
    NSMutableArray *pinnedCertificates = [NSMutableArray array];
    for (NSData *certificateData in self.pinnedCertificates) {
        SecCertificateRef certRef = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)certificateData);
        if(certRef) {
            [pinnedCertificates addObject:CFBridgingRelease(certRef)];
        }
    }
    
    SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)pinnedCertificates);
    
    NSUInteger trustedCertificateCount = 0;
    for (NSData *trustChainCertificate in [self getTrustchainForTrustRef:serverTrust]) {
        if ([self.pinnedCertificates containsObject:trustChainCertificate]) {
            trustedCertificateCount++;
        }
    }
    
    return trustedCertificateCount > 0 && [self validateTrustRef:serverTrust];
}

- (BOOL)evaluateCertTrustAgainstMasterCert:(SecTrustRef)secTrust {
    return NO;
}

- (void)overridePinnedCerts:(NSArray<NSData *> *)certs {
    self.pinnedCertificates = certs;
}

#pragma mark - Private methods

// Get an array of trust chains for SecTrustRef
- (NSArray *)getTrustchainForTrustRef:(SecTrustRef)trustRef {
    CFIndex certificateCount = SecTrustGetCertificateCount(trustRef);
    NSMutableArray *serverTrustChain = [NSMutableArray arrayWithCapacity:(NSUInteger)certificateCount];
    
    for (CFIndex i = 0; i < certificateCount; i++) {
        SecCertificateRef certificate = SecTrustGetCertificateAtIndex(trustRef, i);
        [serverTrustChain addObject:CFBridgingRelease(SecCertificateCopyData(certificate))];
    }
    
    return serverTrustChain;
}

// Search the bundle for files with .cer file ending.
- (NSArray *)getPinnedCertificates {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSArray *rootPaths = [bundle pathsForResourcesOfType:@"cer" inDirectory:@"."];
    
    NSMutableArray *certificates = [NSMutableArray arrayWithCapacity:[rootPaths count]];
    for (NSString *path in rootPaths) {
        NSData *certificateData = [NSData dataWithContentsOfFile:path];
        [certificates addObject:certificateData];
    }
    
    return certificates;
}

// Validate a SecTrustRef
- (BOOL)validateTrustRef:(SecTrustRef)trustRef {
    SecTrustResultType result;
    SecTrustEvaluate(trustRef, &result);
    
    return (result == kSecTrustResultUnspecified || result == kSecTrustResultProceed);
}

@end
