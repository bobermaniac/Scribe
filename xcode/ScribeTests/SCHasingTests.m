//
//  SCHasingTests.m
//  Scribe
//
//  Created by Victor Bryksin on 19/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Scribe/Scribe.h>

@interface SCHasingTests : XCTestCase

@end

@implementation SCHasingTests

- (void)testNSArrayHash {
    NSArray *a1 = @[ @1, @2, @3, @4, @5 ];
    NSArray *a2 = @[ @1, @2, @3, @4, @5 ];
    NSArray *a3 = @[ @9, @7, @5, @4, @5 ];
    NSArray *a4 = @[ @1, @2, @3, @4 ];
    XCTAssertEqual(SCObjectHash(a1), SCObjectHash(a2));
    XCTAssertNotEqual(SCObjectHash(a1), SCObjectHash(a3));
    XCTAssertNotEqual(SCObjectHash(a1), SCObjectHash(a4));
}

@end
