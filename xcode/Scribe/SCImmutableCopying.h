//
//  SCImmutableCopying.h
//  Scribe
//
//  Created by Victor Bryksin on 16/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * _Nonnull const SCImmutableCopyingErrorDomain;
extern NSInteger const SCCannotMakeImmutableCopyOfComplexObjectErrorCode;

/**
 *  Conform this protocol to declare your class as immutable or give possibility to make immutable copy of it
 */
@protocol SCImmutableCopying <NSObject>

#pragma mark - Required

@required
/**
 *  Returns YES if class declared as immutable
 */
@property (nonatomic, readonly, getter=isImmutable) BOOL immutable;

#pragma mark - Optional

@optional
/**
 *  Returns instance of immutable verison of current class with same data (e.g. NSArray for NSMutableArray)
 *
 *  @param error Variable to return possible error info
 *
 *  @return Immutable class instance
 */
- (id _Nullable)immutableCopyWithError:(NSError * _Nullable __autoreleasing * _Nullable)error;

@end