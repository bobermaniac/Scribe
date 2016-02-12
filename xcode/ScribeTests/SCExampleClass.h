//
//  SCExampleClass.h
//  Scribe
//
//  Created by Victor Bryksin on 12/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scribe.h"

scribe(implement mutable, builder, archivable, )
@interface SCExampleClass : NSObject

@property (nonatomic, strong, readonly, nonnull) NSString *ID;
@property (nonatomic, strong, nullable) NSString *description;

@property (nonatomic, strong) NSArray<NSString *> *components;

@end