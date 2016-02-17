//
//  SCTracker.h
//  Scribe
//
//  Created by Victor Bryksin on 13/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SCTracker <NSObject>

@required
@property (nonatomic, readonly, nonnull) NSArray<NSString *> *changedKeys;

- (id _Nullable)initialValueForKey:(NSString * _Nonnull)key;
- (id _Nullable)finalValueForKey:(NSString * _Nonnull)key;

@end

@protocol SCTracking <SCTracker, NSCopying>

@required
- (void)property:(NSString * _Nonnull)name beforeChangeValue:(id _Nullable)value;
- (void)property:(NSString * _Nonnull)name afterChangeValue:(id _Nullable)value;

@end
