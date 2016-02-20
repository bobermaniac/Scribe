//
//  NSDate+SCImmutableCopying.m
//  Scribe
//
//  Created by Victor Bryksin on 17/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "NSDate+SCImmutableCopying.h"

@implementation NSDate (SCImmutableCopying)

- (BOOL)isImmutable {
    return YES;
}

- (NSUInteger)SC_hash {
    return self.hash;
}

@end
