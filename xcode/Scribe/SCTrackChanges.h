//
//  SCTrackChanges.h
//  Scribe
//
//  Created by Victor Bryksin on 07/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCTracker.h"

@protocol SCTrackChanges <NSObject>

@property (nonatomic, strong, nonnull, readonly) id<SCTracker> changesTracker;

@end
