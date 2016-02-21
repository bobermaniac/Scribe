//
//  SCExampleClassTests.m
//  Scribe
//
//  Created by Victor Bryksin on 22/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCExampleClass.h"

@interface SCExampleClassTests : XCTestCase

@end

@implementation SCExampleClassTests

- (void)testExampleClassHashing {
    SCExampleClassBuilder *builder = [SCExampleClass builder];
    builder.ID = @"ID";
    [builder applyObjectDescription:@"Some?"];
    SCExampleClass *class = [builder buildWithError:nil];
    NSUInteger hash = class.hash;
    hash = class.hash;
}

@end
