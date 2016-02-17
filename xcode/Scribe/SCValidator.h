//
//  SCValidator.h
//  Scribe
//
//  Created by Victor Bryksin on 08/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * _Nonnull const SCValidationErrorDomain;
extern NSInteger const SCValidationFailedErrorCode;
extern NSInteger const SCInvalidTypeErrorCode;

@protocol SCValidator <NSObject>

@required
+ (instancetype _Nonnull)validator;

// TODO: pack additional params into dictionary and provide it optionally
- (BOOL)validateValue:(nullable id)value ofProperty:(nonnull NSString *)property forObject:(nullable id)object error:(NSError * _Nullable __autoreleasing * _Nullable)error;

@end

@interface SCValidationError : NSError

- (instancetype _Nonnull)initWithCode:(NSInteger)code validator:(id<SCValidator> _Nonnull)validator;
+ (SCValidationError * _Nonnull)validationErrorWithValidator:(id<SCValidator> _Nonnull)validator;
+ (SCValidationError * _Nonnull)invalidTypeWithValidator:(id<SCValidator> _Nonnull)validator;

@property (nonatomic, strong, readonly) id<SCValidator> _Nonnull validator;

@end