//
//  NSMutableArray+SCImmutableCopying.m
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "NSArray+SCImmutableCopying.h"
#import "SCImmutableCopyingHelpers.h"

@implementation NSArray (SCImmutableCopying)

- (BOOL)isImmutable {
    return SCEnumerableContentsAreImmutable(self);
}

- (id)immutableCopyWithError:(NSError *__autoreleasing  _Nullable *)error {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    for (id<SCImmutableCopying> obj in self) {
        id copy = SCObjectImmutableCopy(obj, error);
        if (!copy) {
            return nil;
        }
        [result addObject:copy];
    }
    return [NSArray arrayWithArray:result];
}

- (NSUInteger)SC_hash {
    return SCEnumerableHash(self, YES);
}

@end

@implementation NSMutableArray (SCImmutableCopying) 

- (BOOL)isImmutable {
    return NO;
}

@end
