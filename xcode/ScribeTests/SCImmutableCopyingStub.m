//
//  SCImmutableCopyingStub.m
//  Scribe
//
//  Created by Victor Bryksin on 21/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "SCImmutableCopyingStub.h"

@interface SCImmutableCopyingStub () {
    @private
    BOOL _immutable;
    NSUInteger _hash;
}

@end

@implementation SCImmutableCopyingStub

- (instancetype)initWithUnsignedInteger:(NSUInteger)unsignedInteger mutable:(BOOL)mut {
    if (self = [super init]) {
        _hash = unsignedInteger;
        _immutable = !mut;
    }
    return self;
}

- (BOOL)isImmutable {
    return _immutable;
}

- (id)immutableCopyWithError:(NSError *__autoreleasing  _Nullable *)error {
    return IS(_hash);
}

- (NSUInteger)SC_hash {
    return _hash;
}

- (NSUInteger)hash {
    return self.SC_hash;
}

@end
