//
//  SCImmutableCopyingHelpers.h
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL SCObjectIsImmutable(id _Nullable obj);
BOOL SCEnumerableContentsAreImmutable(id<NSFastEnumeration> _Nullable enumerable);
id _Nullable SCObjectImmutableCopy(id _Nullable obj, NSError * _Nullable __autoreleasing * _Nullable error);

NSUInteger SCObjectHash(id _Nullable obj);
NSUInteger _SCStructHash(const void * _Nonnull aStruct, size_t structSize);
NSUInteger SCEnumerableHash(id<NSFastEnumeration> _Nullable enumerable, BOOL positionAware);
NSUInteger SCEnumerableHash(id<NSFastEnumeration> _Nullable enumerable, BOOL positionAware);
NSUInteger SCDictionaryHash(NSDictionary * _Nullable dictionary);

#define SCStructHash(s) _SCStructHash(&s, sizeof(s))

