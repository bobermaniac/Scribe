//
//  NSOrderedSet+SCImmutableCopying.m
//  Scribe
//
//  Created by Victor Bryksin on 17/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "NSOrderedSet+SCImmutableCopying.h"
#import "SCImmutableCopyingHelpers.h"

@implementation NSOrderedSet (SCImmutableCopying)

- (BOOL)isImmutable {
    return SCEnumerableContentsAreImmutable(self);
}

- (id)immutableCopyWithError:(NSError *__autoreleasing  _Nullable *)error {
    NSMutableOrderedSet *result = [NSMutableOrderedSet orderedSetWithCapacity:self.count];
    for (id _Nonnull obj in self) {
        id _Nullable copy = SCObjectImmutableCopy(obj, error);
        if (!copy) {
            return nil;
        }
        [result addObject:copy];
    }
    return [NSOrderedSet orderedSetWithOrderedSet:result];
}

- (NSUInteger)SC_hash {
    return SCEnumerableHash(self, YES);
}

@end

@implementation NSMutableOrderedSet (SCImmutableCopying)

- (BOOL)isImmutable {
    return NO;
}

@end