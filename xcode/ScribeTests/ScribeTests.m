//
//  ScribeTests.m
//  ScribeTests
//
//  Created by Victor Bryksin on 07/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCExampleClass.h"

@interface ScribeTests : XCTestCase

@end

@implementation ScribeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExampleClass {
    NSError *error = nil;
    SCExampleClassBuilder *builder = [SCExampleClass builder];
    builder.ID = @"SomeID";
    builder.objectDescription = @"some description";
    builder.counter = 5;
    SCExampleClass *class = [builder buildWithError:&error];
    SCMutableExampleClass *mutableClass = [class mutableCopy];
    [mutableClass addComponent:@"Component 1" error:&error];
    [mutableClass addComponent:@"Component 2" error:&error];
    class = [[SCExampleClass alloc] initWithExampleClass:mutableClass];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
