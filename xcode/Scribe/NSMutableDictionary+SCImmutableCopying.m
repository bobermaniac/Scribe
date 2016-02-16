//
//  NSMutableDictionary+SCImmutableCopying.m
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "NSMutableDictionary+SCImmutableCopying.h"

@implementation NSMutableDictionary (SCImmutableCopying)

- (id)immutableCopyWithZone:(NSZone *)zone {
    return [[NSDictionary allocWithZone:zone] initWithDictionary:self];
}

@end
