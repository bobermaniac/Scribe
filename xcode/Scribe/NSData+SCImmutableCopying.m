//
//  NSData+SCImmutableCopying.m
//  Scribe
//
//  Created by Victor Bryksin on 17/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "NSData+SCImmutableCopying.h"

@implementation NSData (SCImmutableCopying)

- (BOOL)isImmutable {
    return YES;
}

@end

@implementation NSMutableData (SCImmutableCopying)

- (BOOL)isImmutable {
    return NO;
}

- (id)immutableCopyWithError:(NSError *__autoreleasing  _Nullable *)error {
    return [NSData dataWithData:self];
}

@end
