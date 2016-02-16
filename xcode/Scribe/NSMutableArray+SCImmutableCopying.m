//
//  NSMutableArray+SCImmutableCopying.m
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "NSMutableArray+SCImmutableCopying.h"

@implementation NSMutableArray (SCImmutableCopying) 

- (id)immutableCopyWithZone:(NSZone *)zone {
    return [[NSArray allocWithZone:zone] initWithArray:self];
}

@end
