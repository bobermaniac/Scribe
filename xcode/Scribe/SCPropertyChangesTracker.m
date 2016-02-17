//
//  SCPropertyChangesTracker.m
//  Scribe
//
//  Created by Victor Bryksin on 08/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "SCPropertyChangesTracker.h"

@implementation SCPropertyChangesTracker

+ (instancetype)trackerWithTrackingObject:(id)object mode:(SCPropertyChangesTrackerMode)mode {
    return [[self alloc] initWithTrackingObject:object mode:mode];
}

- (instancetype)initWithTrackingObject:(id)object mode:(SCPropertyChangesTrackerMode)mode {
    NSParameterAssert(mode == SCPropertyChangesTrackerManualMode);
    if (self = [super init]) {
        _trackingObject = object;
        _mode = mode;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[SCPropertyChangesTracker allocWithZone:zone] initWithTrackingObject:self.trackingObject mode:self.mode];
}

- (void)property:(NSString *)name beforeChangeValue:(id)value {
    
}

- (void)property:(NSString *)name afterChangeValue:(id)value {
    
}

- (id)initialValueForKey:(NSString *)key {
    return nil;
}

- (id)finalValueForKey:(NSString *)key {
    return nil;
}

- (NSArray<NSString *> *)changedKeys {
    return @[ ];
}

@end
