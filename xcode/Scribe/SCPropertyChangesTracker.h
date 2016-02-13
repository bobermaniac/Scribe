//
//  SCPropertyChangesTracker.h
//  Scribe
//
//  Created by Victor Bryksin on 08/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCTracker.h"

typedef NS_ENUM(NSUInteger, SCPropertyChangesTrackerMode) {
    SCPropertyChangesTrackerAutomaticMode,
    SCPropertyChangesTrackerManualMode
};

@interface SCPropertyChangesTracker : NSObject<NSCopying, SCTracking>

- (nullable instancetype)initWithTrackingObject:(nonnull id)object mode:(SCPropertyChangesTrackerMode)mode;
+ (nullable instancetype)trackerWithTrackingObject:(nonnull id)object mode:(SCPropertyChangesTrackerMode)mode;

@property (nonatomic, assign, readonly) SCPropertyChangesTrackerMode mode;
@property (nonatomic, weak, readonly) id trackingObject;

@end
