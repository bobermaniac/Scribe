//
//  SCImmutableCopyingStub.h
//  Scribe
//
//  Created by Victor Bryksin on 21/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Scribe/Scribe.h>

@interface SCImmutableCopyingStub : NSObject<SCImmutableCopying>

- (instancetype _Nonnull)initWithUnsignedInteger:(NSUInteger)unsignedInteger mutable:(BOOL)mut;

@end

#define MS(i) [[SCImmutableCopyingStub alloc] initWithUnsignedInteger:i mutable:YES]
#define IS(i) [[SCImmutableCopyingStub alloc] initWithUnsignedInteger:i mutable:NO]