//
//  BNCacheManager.m
//  Pods
//
//  Created by Bambora On Mobile AB on 17/09/2015.
//
//

#import "BNCacheManager.h"
#import "NSString+BNStringUtils.h"

static NSString *const CacheDir = @"BNCacheDir";

@implementation BNCacheManager {
    NSString *_cacheDir;
}

+ (BNCacheManager *)sharedCache{
    static dispatch_once_t once;
    static BNCacheManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init{
    self = [super init];
    if (self){
        _cacheDir = [NSString stringWithFormat:@"%@/%@",[self getRootDirectory], CacheDir];
        
        if ( ![[NSFileManager defaultManager] fileExistsAtPath:_cacheDir] ) {
            [[NSFileManager defaultManager] createDirectoryAtPath:_cacheDir
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
    }
    return self;
}

- (BOOL)saveObject:(NSObject *)object withName:(NSString *)name {
    if (object && name) {
        NSString* filename = [_cacheDir stringByAppendingPathComponent:name];
        return [NSKeyedArchiver archiveRootObject:object toFile:filename];
    }

    return NO;
}

- (id<NSCoding>)getObjectWithName:(NSString *)name {
    if (name) {
        NSString *filename = [_cacheDir stringByAppendingPathComponent:name];
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    }
    
    return nil;
}

-(NSString *)getRootDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
}

@end
