//
//  SCTrackerTests.m
//  Scribe
//
//  Created by Victor Bryksin on 17/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Scribe/Scribe.h>

@interface SCTestClassWithFields : NSObject

@property (nonatomic, strong) NSString *f1;
@property (nonatomic, assign) int f2;

@end

@implementation SCTestClassWithFields

@end

@interface SCTrackerTests : XCTestCase

@end

@implementation SCTrackerTests

- (void)testTrackerWritingSingleChangeManual {
    id<SCTracking> tracking = [[SCPropertyChangesTracker alloc] initWithTrackingObject:self mode:SCPropertyChangesTrackerManualMode];
    
    [tracking property:@"p" beforeChangeValue:nil];
    [tracking property:@"p" afterChangeValue:@"g"];
    XCTAssertTrue([tracking.changedKeys containsObject:@"p"]);
}

- (void)testTrackerWritingOverlappingChangesManual {
    id<SCTracking> tracking = [[SCPropertyChangesTracker alloc] initWithTrackingObject:self mode:SCPropertyChangesTrackerManualMode];
    
    [tracking property:@"p" beforeChangeValue:nil];
    [tracking property:@"q" beforeChangeValue:nil];
    [tracking property:@"p" afterChangeValue:@"g"];
    [tracking property:@"q" afterChangeValue:@"g"];
    XCTAssertTrue([tracking.changedKeys containsObject:@"p"]);
    XCTAssertTrue([tracking.changedKeys containsObject:@"q"]);
}

- (void)testTrackerWritingNestedChangesManual {
    id<SCTracking> tracking = [[SCPropertyChangesTracker alloc] initWithTrackingObject:self mode:SCPropertyChangesTrackerManualMode];
    
    [tracking property:@"p" beforeChangeValue:nil];
    [tracking property:@"q" beforeChangeValue:nil];
    [tracking property:@"q" afterChangeValue:@"g"];
    [tracking property:@"p" afterChangeValue:@"g"];
    XCTAssertTrue([tracking.changedKeys containsObject:@"p"]);
    XCTAssertTrue([tracking.changedKeys containsObject:@"q"]);
}

- (void)testTrackerRemovesReversedChangesManual {
    id<SCTracking> tracking = [[SCPropertyChangesTracker alloc] initWithTrackingObject:self mode:SCPropertyChangesTrackerManualMode];
    
    [tracking property:@"p" beforeChangeValue:nil];
    [tracking property:@"p" afterChangeValue:@"g"];
    [tracking property:@"p" beforeChangeValue:@"g"];
    [tracking property:@"p" afterChangeValue:nil];
    XCTAssertFalse([tracking.changedKeys containsObject:@"p"]);
}

- (void)testTrackerChecksConsistency {
    id<SCTracking> tracking = [[SCPropertyChangesTracker alloc] initWithTrackingObject:self mode:SCPropertyChangesTrackerManualMode];
    
    [tracking property:@"p" beforeChangeValue:nil];
    [tracking property:@"p" afterChangeValue:@"g"];
    XCTAssertThrows([tracking property:@"p" beforeChangeValue:@"r"]);
}

- (void)testTrackerAccessToInitialAndFinalValues {
    id<SCTracking> tracking = [[SCPropertyChangesTracker alloc] initWithTrackingObject:self mode:SCPropertyChangesTrackerManualMode];
    
    [tracking property:@"p" beforeChangeValue:nil];
    [tracking property:@"p" afterChangeValue:@"g"];
    XCTAssertEqualObjects([tracking initialValueForKey:@"p"], nil);
    XCTAssertEqualObjects([tracking finalValueForKey:@"p"], @"g");
}

- (void)testTrackerWritingSingleChangeAutomatic {
    SCTestClassWithFields *c = [[SCTestClassWithFields alloc] init];
    
    id<SCTracking> tracking = [[SCPropertyChangesTracker alloc] initWithTrackingObject:c mode:SCPropertyChangesTrackerAutomaticMode];
    c.f1 = @"Hello";
    c.f2 = 5;
    XCTAssertTrue([tracking.changedKeys containsObject:@"f1"]);
    XCTAssertEqualObjects([tracking initialValueForKey:@"f1"], nil);
    XCTAssertEqualObjects([tracking finalValueForKey:@"f1"], @"Hello");
    XCTAssertTrue([tracking.changedKeys containsObject:@"f2"]);
    XCTAssertEqualObjects([tracking initialValueForKey:@"f2"], @0);
    XCTAssertEqualObjects([tracking finalValueForKey:@"f2"], @5);
}

@end
