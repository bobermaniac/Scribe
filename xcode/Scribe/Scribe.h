//
//  Scribe.h
//  Scribe
//
//  Created by Victor Bryksin on 07/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for Scribe.
FOUNDATION_EXPORT double ScribeVersionNumber;

//! Project version string for Scribe.
FOUNDATION_EXPORT const unsigned char ScribeVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Scribe/PublicHeader.h>

#import <Scribe/SCValidator.h>
#import <Scribe/SCTrackChanges.h>
#import <Scribe/SCPropertyChangesTracker.h>
#import <Scribe/SCImmutableCopying.h>
#import <Scribe/SCImmutableCopyingHelpers.h>

#import <Scribe/SCNonnullValidator.h>
#import <Scribe/SCNonemptyStringValidator.h>

#define scribe(...)
