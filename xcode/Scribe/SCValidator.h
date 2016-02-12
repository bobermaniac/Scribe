//
//  SCValidator.h
//  Scribe
//
//  Created by Victor Bryksin on 08/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SCValidator <NSObject>

@required
- (BOOL)validateValue:(nullable id)value ofProperty:(nonnull NSString *)property forObject:(nullable id)object error:(NSError * _Nullable __autoreleasing * _Nullable)error;

@end
