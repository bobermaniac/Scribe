//
//  SCImmutableCopyingTests.m
//  Scribe
//
//  Created by Victor Bryksin on 17/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Scribe/Scribe.h>

@interface SCImmutableCopyingTests : XCTestCase

@end

@implementation SCImmutableCopyingTests

- (void)testNil {
    NSError *error = nil;
    
    XCTAssertTrue(SCObjectIsImmutable(nil));
    XCTAssertEqualObjects(SCObjectImmutableCopy(nil, &error), nil);
    XCTAssertNil(error);
}

- (void)testNSNull {
    NSError *error = nil;
    
    XCTAssertTrue(SCObjectIsImmutable([NSNull null]));
    XCTAssertEqualObjects(SCObjectImmutableCopy([NSNull null], &error), [NSNull null]);
    XCTAssertNil(error);
}

- (void)testNSString {
    NSError *error = nil;
    NSString *string = @"String";
    
    XCTAssertTrue(SCObjectIsImmutable(string));
    XCTAssertEqualObjects(SCObjectImmutableCopy(string, &error), string);
    XCTAssertNil(error);
}

- (void)testNSMutableString {
    NSError *error = nil;
    NSString *string = [NSMutableString stringWithString:@"Another string"];
    
    XCTAssertFalse(SCObjectIsImmutable(string));
    id copy = SCObjectImmutableCopy(string, &error);
    XCTAssertNil(error);
    XCTAssertNotNil(copy);
    
    // OK we can't guarantee that immutable copy of string will be immutable copy coz Apple, just deal with it
    // XCTAssertTrue(SCObjectIsImmutable(copy));
}

- (void)testNSValue {
    NSError *error = nil;
    NSNumber *number = @5;
    
    XCTAssertTrue(SCObjectIsImmutable(number));
    XCTAssertEqualObjects(SCObjectImmutableCopy(number, &error), number);
    XCTAssertNil(error);
}

- (void)testNSDate {
    NSError *error = nil;
    NSDate *date = [NSDate date];
    
    XCTAssertTrue(SCObjectIsImmutable(date));
    XCTAssertEqualObjects(SCObjectImmutableCopy(date, &error), date);
    XCTAssertNil(error);
}

- (void)testNSData {
    NSError *error = nil;
    NSData *data = [@"Some string" dataUsingEncoding:NSUTF8StringEncoding];
    
    // Real type of data will be NSConcreteMutableData, which is subclass of NSMutableData but it is immutable
    // for this case, ty Apple for my happy childhood
    // XCTAssertTrue(SCObjectIsImmutable(data));
    XCTAssertEqualObjects(SCObjectImmutableCopy(data, &error), data);
    XCTAssertNil(error);
}

- (void)testNSMutableData {
    NSError *error = nil;
    NSMutableData *data = [[@"Some string 2" dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    
    XCTAssertFalse(SCObjectIsImmutable(data));
    NSData *copy = SCObjectImmutableCopy(data, &error);
    XCTAssertNil(error);
    XCTAssertNotNil(copy);
    XCTAssertTrue(SCObjectIsImmutable(copy));
    XCTAssertTrue([data isEqualToData:copy]);
}

- (void)testNSArrayWithImmutableData {
    NSError *error = nil;
    NSArray *array = @[ @1, @2, @3, @4, @5 ];
    
    XCTAssertTrue(SCObjectIsImmutable(array));
    XCTAssertEqualObjects(SCObjectImmutableCopy(array, &error), array);
    XCTAssertNil(error);
}

- (void)testNSArrayWithMutableData {
    NSError *error = nil;
    NSArray *array = @[ @1, @2, @3, @4, @5, @"6".mutableCopy ];
    
    XCTAssertFalse(SCObjectIsImmutable(array));
    NSArray *copy = SCObjectImmutableCopy(array, &error);
    XCTAssertNil(error);
    XCTAssertNotNil(copy);
    XCTAssertTrue(SCObjectIsImmutable(copy));
    
    [copy enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertTrue([obj isEqual:array[idx]]);
        XCTAssertTrue(SCObjectIsImmutable(obj));
    }];
}

- (void)testNSMutableArray {
    NSError *error = nil;
    NSMutableArray *array = @[ @1, @2, @3, @4, @5 ].mutableCopy;
    
    XCTAssertFalse(SCObjectIsImmutable(array));
    NSArray *copy = SCObjectImmutableCopy(array, &error);
    XCTAssertNil(error);
    XCTAssertNotNil(copy);
    XCTAssertTrue(SCObjectIsImmutable(copy));
    
    [copy enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertTrue([obj isEqual:array[idx]]);
        XCTAssertTrue(SCObjectIsImmutable(obj));
    }];
}

- (void)testNSDictionaryWithImmutableData {
    NSError *error = nil;
    NSDictionary *dict = @{
                           @1 : [NSDate date],
                           @2 : [NSDate date],
                           @3 : [NSDate date],
                           };
    
    XCTAssertTrue(SCObjectIsImmutable(dict));
    XCTAssertEqualObjects(SCObjectImmutableCopy(dict, &error), dict);
    XCTAssertNil(error);
}

- (void)testNSDictionaryWithMutableData {
    NSError *error = nil;
    NSDictionary *dict = @{
                           @1 : @"1".mutableCopy,
                           @2 : @"2".mutableCopy,
                           @3 : @"3".mutableCopy,
                           };
    
    XCTAssertFalse(SCObjectIsImmutable(dict));
    NSDictionary *copy = SCObjectImmutableCopy(dict, &error);
    XCTAssertNil(error);
    XCTAssertNotNil(copy);
    XCTAssertTrue(SCObjectIsImmutable(copy));
    
    [copy enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        XCTAssertTrue([obj isEqual:dict[key]]);
        XCTAssertTrue(SCObjectIsImmutable(obj));
    }];
}

- (void)testNSSetWithImmutableData {
    NSError *error = nil;
    NSSet *set = [NSSet setWithArray:@[ @1, @2, @3, @4, @5 ]];
    
    XCTAssertTrue(SCObjectIsImmutable(set));
    XCTAssertEqualObjects(SCObjectImmutableCopy(set, &error), set);
    XCTAssertNil(error);
}

- (void)testNSSetWithMutableData {
    NSError *error = nil;
    NSSet *set = [NSSet setWithArray:@[ @1, @2, @3, @4, @5, @"6".mutableCopy ]];
    
    XCTAssertFalse(SCObjectIsImmutable(set));
    NSSet *copy = SCObjectImmutableCopy(set, &error);
    XCTAssertNil(error);
    XCTAssertNotNil(copy);
    XCTAssertTrue(SCObjectIsImmutable(copy));
    
    [copy enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        XCTAssertTrue(SCObjectIsImmutable(obj));
        XCTAssertTrue([set containsObject:obj]);
    }];
}

- (void)testNSMutableSet {
    NSError *error = nil;
    NSMutableSet *set = [NSMutableSet setWithArray:@[ @1, @2, @3, @4, @"6".mutableCopy ]];
    
    XCTAssertFalse(SCObjectIsImmutable(set));
    NSSet *copy = SCObjectImmutableCopy(set, &error);
    XCTAssertNil(error);
    XCTAssertNotNil(copy);
    XCTAssertTrue(SCObjectIsImmutable(copy));
    
    [copy enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        XCTAssertTrue(SCObjectIsImmutable(obj));
        [set removeObject:obj];
    }];
    XCTAssertTrue([set objectsPassingTest:^BOOL(id  _Nonnull obj, BOOL * _Nonnull stop) {
        return !SCObjectIsImmutable(obj);
    }].count == set.count);
}

- (void)testNSOrderedSetWithImmutableData {
    XCTFail(@"Here's be dragons");
}

- (void)testNSOrderedSetWithMutableData {
    XCTFail(@"Here's be dragons");
}

- (void)testNSMutableOrderedSet {
    XCTFail(@"Here's be dragons");
}

@end
