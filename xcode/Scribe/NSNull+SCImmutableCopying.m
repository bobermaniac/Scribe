//
//  NSNull+SCImmutableCopying.m
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "NSNull+SCImmutableCopying.h"

@implementation NSNull (SCImmutableCopying)

- (BOOL)isImmutable {
    return YES;
}

- (id)immutableCopyWithError:(NSError *__autoreleasing  _Nullable *)error {
    return [NSNull null];
}

@end
