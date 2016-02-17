//
//  SCImmutableCopyingHelpers.m
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "SCImmutableCopyingHelpers.h"
#import "SCImmutableCopying.h"

NSString * const SCImmutableCopyingErrorDomain = @"Scribe::ImmutableCopying";
NSInteger const SCCannotMakeImmutableCopyOfComplexObjectErrorCode = -1;

@interface SCObjectCantBeImmutableError : NSError

- (instancetype)initWithObject:(id)object NS_DESIGNATED_INITIALIZER;

@end

@implementation SCObjectCantBeImmutableError

- (instancetype)initWithObject:(id)object {
    NSString *localizedDescription = [NSString stringWithFormat:@"It is impossible to create immutable copy of object %@", object];
    NSString *localizedFailureReason = [NSString stringWithFormat:@"Object of class %@ have no immutable version", [object class]];
    NSString *localizedRecoverySuggestion = @"You can implement protocol SCImmutableCopying for this class manually";
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey : localizedDescription,
                               NSLocalizedFailureReasonErrorKey : localizedFailureReason,
                               NSLocalizedRecoverySuggestionErrorKey : localizedRecoverySuggestion,
                               };
    
    if (self = [super initWithDomain:SCImmutableCopyingErrorDomain code:SCCannotMakeImmutableCopyOfComplexObjectErrorCode userInfo:userInfo]) {
        
    }
    return self;
}

- (instancetype)initWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)dict {
    @throw [NSException exceptionWithName:@"Forbidden" reason:@"This initializer is forbidden for call" userInfo:@{}];
    return [self initWithObject:self];
}

@end

BOOL SCObjectIsImmutable(id obj) {
    if (!obj) {
        return YES;
    }
    if (![obj conformsToProtocol:@protocol(SCImmutableCopying)]) {
        return NO;
    }
    if (![obj isImmutable]) {
        return NO;
    }
    return YES;
}

BOOL SCEnumerableContentsAreImmutable(id<NSFastEnumeration> enumerable) {
    for (id obj in enumerable) {
        if (!SCObjectIsImmutable(obj)) {
            return NO;
        }
    }
    return YES;
}

id SCObjectImmutableCopy(id obj, NSError ** error) {
    if (!obj) {
        return obj;
    }
    if (![obj conformsToProtocol:@protocol(SCImmutableCopying)]) {
        if (error) {
            *error = [[SCObjectCantBeImmutableError alloc] initWithObject:obj];
        }
        return nil;
    }
    if ([obj isImmutable]) {
        return obj;
    }
    return [obj immutableCopyWithError:error];
}