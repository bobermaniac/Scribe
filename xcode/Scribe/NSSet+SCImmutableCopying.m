//
//  NSSet+SCImmutableCopying.m
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "NSSet+SCImmutableCopying.h"
#import "SCImmutableCopyingHelpers.h"

@implementation NSSet (SCImmutableCopying)

- (BOOL)isImmutable {
    return SCEnumerableContentsAreImmutable(self);
}

- (id)immutableCopyWithError:(NSError *__autoreleasing  _Nullable *)error {
    NSMutableSet *result = [NSMutableSet setWithCapacity:self.count];
    for (id obj in self) {
        id copy = SCObjectImmutableCopy(obj, error);
        if (!copy) {
            return nil;
        }
        [result addObject:copy];
    }
    return [NSSet setWithSet:result];
}

- (NSUInteger)SC_hash {
    return SCEnumerableHash(self, NO);
}

@end

@implementation NSMutableSet (SCImmutableCopying)

- (BOOL)isImmutable {
    return NO;
}

@end