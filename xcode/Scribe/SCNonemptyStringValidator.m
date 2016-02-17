//
//  SCNonemptyStringValidator.m
//  Scribe
//
//  Created by Victor Bryksin on 13/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "SCNonemptyStringValidator.h"

@implementation SCNonemptyStringValidator

- (BOOL)validateValue:(id)value ofProperty:(NSString *)property forObject:(id)object error:(NSError **)error {
    if (value && ![value isKindOfClass:[NSString class]]) {
        if (error) {
            *error = [SCValidationError invalidTypeWithValidator:self];
        }
        return NO;
    }
    if (![value length]) {
        if (error) {
            *error = [SCValidationError validationErrorWithValidator:self];
        }
        return NO;
    }
    return YES;
}

+ (instancetype)validator {
    return [[self alloc] init];
}

@end
