//
//  NSObject+SCImmutableCopying.m
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "NSObject+SCImmutableCopying.h"
#import <SCImmutableCopying.h>

@implementation NSObject (SCImmutableCopying)

-  (id)immutableCopy {
    if ([self conformsToProtocol:@protocol(SCImmutableCopying)]) {
        return [((id<SCImmutableCopying>)self) immutableCopyWithZone:nil];
    }
    return [self copy];
}

@end
