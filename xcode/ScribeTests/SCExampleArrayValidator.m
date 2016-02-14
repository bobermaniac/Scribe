//
//  SCExampleArrayValidator.m
//  Scribe
//
//  Created by Victor Bryksin on 14/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import "SCExampleArrayValidator.h"

@implementation SCExampleArrayValidator

- (BOOL)validateValue:(NSArray<NSString *> *)value ofProperty:(NSString *)property forObject:(id)object error:(NSError *__autoreleasing  _Nullable *)error {
    if (value.count <= 1) {
        return YES;
    }
    if (error) {
        *error = [NSError errorWithDomain:@"Validation" code:-1 userInfo:@{}];
    }
    return NO;
}

@end
