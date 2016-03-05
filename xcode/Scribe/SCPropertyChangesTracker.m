//
//  SCPropertyChangesTracker.m
//  Scribe
//
//  Created by Victor Bryksin on 08/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "SCPropertyChangesTracker.h"

@interface SCPropertyChange : NSObject

+ (nonnull instancetype)propertyChangeWithInitialValue:(id)initialValue;

- (nonnull instancetype)initWithInitialValue:(id)initialValue;

@property (nonatomic, strong) id initialValue;
@property (nonatomic, strong) id finalValue;

@property (nonatomic, assign, readonly, getter=isIdentity) BOOL identity;

@end

@implementation SCPropertyChange

+ (instancetype)propertyChangeWithInitialValue:(id)initialValue {
    return [[self alloc] initWithInitialValue:initialValue];
}

- (instancetype)initWithInitialValue:(id)initialValue {
    if (self = [super init]) {
        self.initialValue = initialValue;
    }
    return self;
}

- (BOOL)isIdentity {
    if (!self.initialValue) {
        if (!self.finalValue) {
            return YES;
        }
        return NO;
    }
    if (!self.finalValue) {
        return NO;
    }
    return [self.initialValue isEqual:self.finalValue];
}

@end

@interface SCPropertyChangesTracker () {
    @private
    NSMutableDictionary<NSString *, SCPropertyChange *> * _changes;
}

@end

@implementation SCPropertyChangesTracker

+ (instancetype)trackerWithTrackingObject:(id)object mode:(SCPropertyChangesTrackerMode)mode {
    return [[self alloc] initWithTrackingObject:object mode:mode];
}

- (instancetype)initWithTrackingObject:(id)object mode:(SCPropertyChangesTrackerMode)mode {
    NSParameterAssert(mode == SCPropertyChangesTrackerManualMode);
    if (self = [super init]) {
        _trackingObject = object;
        _mode = mode;
        _changes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)initWithTracker:(SCPropertyChangesTracker *)tracker {
    if (self = [self initWithTrackingObject:tracker.trackingObject mode:tracker.mode]) {
        _changes = [tracker->_changes copy];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[self.class alloc] initWithTracker:self];
}

- (void)property:(NSString *)name beforeChangeValue:(id)value {
    [self _captureInitialValue:value forPropertyNamed:name];
}

- (void)property:(NSString *)name afterChangeValue:(id)value {
    [self _updateFinalValue:value forPropertyNamed:name];
}

- (void)_captureInitialValue:(id)initialValue forPropertyNamed:(NSString *)name {
    SCPropertyChange *change = _changes[name];
    if (!change) {
        change = [SCPropertyChange propertyChangeWithInitialValue:initialValue];
        _changes[name] = change;
    } else {
        if (change.finalValue != initialValue) {
            [NSException raise:@"Internal inconsistency" format:@"Tracking impossible for property %@: some changes can be missed", name];
        }
    }
}

-(void)_updateFinalValue:(id)finalValue forPropertyNamed:(NSString *)name {
    SCPropertyChange *change = _changes[name];
    if (!change) {
        [NSException raise:@"Internal inconsistency" format:@"Tracking impossible for property %@: initial value was not captured", name];
    }
    change.finalValue = finalValue;
    if (change.isIdentity) {
        _changes[name] = nil;
    }
}

- (id)initialValueForKey:(NSString *)key {
    return _changes[key].initialValue;
}

- (id)finalValueForKey:(NSString *)key {
    return _changes[key].finalValue;
}

- (NSArray<NSString *> *)changedKeys {
    return _changes.allKeys;
}

@end
