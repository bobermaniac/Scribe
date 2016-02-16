//
//  SCImmutableCopyingHelpers.h
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCObjectCantBeImmutableError : NSError

- (nonnull instancetype)initWithObject:(id _Nonnull)object NS_DESIGNATED_INITIALIZER;

@end

BOOL SCObjectIsImmutable(id _Nonnull obj);
id _Nullable SCObjectImmutableCopy(id _Nonnull obj, NSError * _Nullable __autoreleasing * _Nullable error);