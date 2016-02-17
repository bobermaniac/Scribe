//
//  NSString+SCImmutableCopying.m
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "NSString+SCImmutableCopying.h"

@implementation NSString (SCImmutableCopying)

- (BOOL)isImmutable {
    return YES;
}

@end

@implementation NSMutableString (SCImmutableCopying)

- (BOOL)isImmutable {
    BOOL mutableString = [self isKindOfClass:[NSMutableString class]];
    return NO;
}

- (id)immutableCopyWithError:(NSError *__autoreleasing  _Nullable *)error {
    return [NSString stringWithString:self];
}

@end
