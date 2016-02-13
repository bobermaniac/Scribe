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
    if (!property.length) {
        if (error) {
            *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
        }
        return NO;
    }
    return YES;
}

@end
