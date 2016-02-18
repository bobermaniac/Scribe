//
//  NSString+SCImmutableCopying.m
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "NSString+SCImmutableCopying.h"

Class SCImmutableCopying__NSCFConstantStringClass = nil;

@implementation NSString (SCImmutableCopying)

- (BOOL)isImmutable {
    return YES;
}

- (NSUInteger)deepHash {
    return self.hash;
}

@end

@implementation NSMutableString (SCImmutableCopying)

- (BOOL)isImmutable {
    if (!SCImmutableCopying__NSCFConstantStringClass) {
        SCImmutableCopying__NSCFConstantStringClass = NSClassFromString(@"__NSCFConstantString");
    }
    if (self.class == SCImmutableCopying__NSCFConstantStringClass) {
        return [super isImmutable];
    }
    return NO;
}

- (id)immutableCopyWithError:(NSError *__autoreleasing  _Nullable *)error {
    return [NSString stringWithString:self];
}

@end
