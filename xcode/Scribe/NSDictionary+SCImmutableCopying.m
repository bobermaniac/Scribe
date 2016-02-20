//
//  NSMutableDictionary+SCImmutableCopying.m
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "NSDictionary+SCImmutableCopying.h"
#import "SCImmutableCopyingHelpers.h"

@implementation NSDictionary (SCImmutableCopying)

- (BOOL)isImmutable {
    return [self keysOfEntriesPassingTest:^BOOL(id  _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
        return !SCObjectIsImmutable(obj);
    }].count == 0;
}

- (id)immutableCopyWithError:(NSError *__autoreleasing  _Nullable *)error {
    NSMutableDictionary *result = [self mutableCopy];
    for (id<NSCopying> key in self) {
        id copy = SCObjectImmutableCopy(self[key], error);
        if (!copy) {
            return nil;
        }
        result[key] = copy;
    }
    return [NSDictionary dictionaryWithDictionary:result];
}

- (NSUInteger)SC_hash {
    return SCDictionaryHash(self);
}

@end

@implementation NSMutableDictionary (SCImmutableCopying)

- (BOOL)isImmutable {
    return NO;
}

@end
