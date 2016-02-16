//
//  SCImmutableCopying.h
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SCImmutableCopying <NSObject>

- (id)immutableCopyWithZone:(NSZone *)zone;

@end
