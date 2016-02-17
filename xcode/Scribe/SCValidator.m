//
//  SCValidator.m
//  Scribe
//
//  Created by Victor Bryksin on 17/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "SCValidator.h"

NSString * _Nonnull const SCValidationErrorDomain = @"Validation";
NSInteger const SCValidationFailedErrorCode = -1;
NSInteger const SCInvalidTypeErrorCode = -2;

@implementation SCValidationError

+ (SCValidationError *)invalidTypeWithValidator:(id<SCValidator>)validator {
    return [[self alloc] initWithCode:SCInvalidTypeErrorCode validator:validator];
}

+ (SCValidationError *)validationErrorWithValidator:(id<SCValidator>)validator {
    return [[self alloc] initWithCode:SCValidationFailedErrorCode validator:validator];
}

- (instancetype)initWithCode:(NSInteger)code validator:(id<SCValidator>)validator {
    if (self = [super initWithDomain:SCValidationErrorDomain code:code userInfo:@{}]) {
        _validator = validator;
    }
    return self;
}

@end
