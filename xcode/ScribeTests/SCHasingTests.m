//
//  SCHasingTests.m
//  Scribe
//
//  Created by Victor Bryksin on 19/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Scribe/Scribe.h>

@interface SCHashingTest_HashPlaceholder : NSObject<SCImmutableCopying> {
    @private
    NSUInteger _hash;
}

- (instancetype)initWithHash:(NSUInteger)hash;

@end

@implementation SCHashingTest_HashPlaceholder

- (instancetype)initWithHash:(NSUInteger)hash {
    if (self = [super init]) {
        _hash = hash;
    }
    return self;
}

- (BOOL)isImmutable {
    return YES;
}

- (NSUInteger)SC_hash {
    return _hash;
}

- (BOOL)isEqual:(SCHashingTest_HashPlaceholder *)object {
    if ([object isKindOfClass:[SCHashingTest_HashPlaceholder class]]) {
        return object->_hash == _hash;
    }
    return NO;
}

@end

@interface NSNumber (SCHashingTest_HashPlaceholder)

@property (nonatomic, readonly, assign) SCHashingTest_HashPlaceholder *h;

@end

@implementation NSNumber (SCHashingTest_HashPlaceholder)

- (SCHashingTest_HashPlaceholder *)h {
    return [[SCHashingTest_HashPlaceholder alloc] initWithHash:self.unsignedIntegerValue];
}

@end

@interface SCHasingTests : XCTestCase

@end

@implementation SCHasingTests

- (void)testNSNullHash {
    NSNull *null = [NSNull null];
    NSNull *null2 = [NSNull null];
    
    XCTAssertEqual(SCObjectHash(null), SCObjectHash(null2));
}

- (void)testNSStringHash {
    NSString *s1 = @"This is a string";
    NSString *s2 = [NSString stringWithFormat:@"This is %@", @"a string"];
    NSString *s3 = @"And this is not";
    NSString *s4 = [NSString stringWithFormat:@"And this %@", @"is not"];
    NSString *s5 = [NSMutableString stringWithFormat:@"This %@", @"is a string"];
    
    XCTAssertEqual(SCObjectHash(s1), SCObjectHash(s2));
    XCTAssertNotEqual(SCObjectHash(s1), SCObjectHash(s3));
    XCTAssertNotEqual(SCObjectHash(s1), SCObjectHash(s4));
    XCTAssertEqual(SCObjectHash(s1), SCObjectHash(s5));
}

- (void)testNSValueHash {
    NSValue *v1 = @1;
    NSValue *v2 = @1;
    NSValue *v3 = @2;
    NSValue *v4 = [NSValue valueWithRect:NSMakeRect(0., 0., 50., 50.)];
    NSValue *v5 = [NSValue valueWithRect:NSMakeRect(0., 0., 50., 50.)];
    XCTAssertEqual(SCObjectHash(v1), SCObjectHash(v2));
    XCTAssertNotEqual(SCObjectHash(v1), SCObjectHash(v3));
    XCTAssertNotEqual(SCObjectHash(v1), SCObjectHash(v4));
    XCTAssertEqual(SCObjectHash(v4), SCObjectHash(v5));
}

- (void)testNSDateHash {
    NSDate *d1 = [NSDate dateWithTimeIntervalSinceReferenceDate:10000];
    NSDate *d2 = [NSDate dateWithTimeIntervalSinceReferenceDate:10000];
    NSDate *d3 = [NSDate dateWithTimeIntervalSinceReferenceDate:20000];
    
    XCTAssertEqual(SCObjectHash(d1), SCObjectHash(d2));
    XCTAssertNotEqual(SCObjectHash(d1), SCObjectHash(d3));
}

- (void)testNSDataHash {
    NSData *d1 = [@"Here's be dragons" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *d2 = [[NSString stringWithFormat:@"Here's be %@", @"dragons"] dataUsingEncoding:NSUTF8StringEncoding];
    NSData *d3 = [@"That's all folks" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *d4 = [NSMutableData dataWithData:[@"That's all folks" dataUsingEncoding:NSUTF8StringEncoding]];
    
    XCTAssertEqual(SCObjectHash(d1), SCObjectHash(d2));
    XCTAssertEqual(SCObjectHash(d3), SCObjectHash(d4));
    XCTAssertNotEqual(SCObjectHash(d1), SCObjectHash(d3));
    XCTAssertNotEqual(SCObjectHash(d1), SCObjectHash(d4));
}

- (void)testNSArrayHash {
    NSArray *a1 = @[ (@1).h, (@2).h, (@3).h, (@4).h, (@5).h ];
    NSArray *a2 = @[ (@1).h, (@2).h, (@3).h, (@4).h, (@5).h ];
    NSArray *a3 = @[ (@9).h, (@7).h, (@5).h, (@4).h, (@5).h ];
    NSArray *a4 = @[ (@1).h, (@2).h, (@3).h, (@4).h ];
    NSArray *a5 = @[ (@5).h, (@4).h, (@3).h, (@2).h, (@1).h ];
    
    XCTAssertEqual(SCObjectHash(a1), SCObjectHash(a2));
    XCTAssertNotEqual(SCObjectHash(a1), SCObjectHash(a3));
    XCTAssertNotEqual(SCObjectHash(a1), SCObjectHash(a4));
    XCTAssertNotEqual(SCObjectHash(a1), SCObjectHash(a5));
}

- (void)testNSDictionaryHash {
    NSDictionary *d1 = @{ @"k" : @1, @"v" : @2 };
    NSDictionary *d2 = @{ @"k" : @1, @"v" : @2 };
    NSDictionary *d3 = @{ @"k" : @2, @"v" : @1 };
    NSDictionary *d4 = @{ @"a" : @1, @"b" : @2 };
    NSDictionary *d5 = @{ @"k" : @1, @"v" : @2, @"b" : @3 };
    NSDictionary *d6 = @{ @"v" : @2, @"k" : @1 };
    
    XCTAssertEqual(SCObjectHash(d1), SCObjectHash(d2));
    XCTAssertNotEqual(SCObjectHash(d1), SCObjectHash(d3));
    XCTAssertNotEqual(SCObjectHash(d1), SCObjectHash(d4));
    XCTAssertNotEqual(SCObjectHash(d1), SCObjectHash(d5));
    XCTAssertEqual(SCObjectHash(d1), SCObjectHash(d6));
}

- (void)testNSSetHash {
    NSSet *a1 = [NSSet setWithArray:@[ (@1).h, (@2).h, (@3).h, (@4).h, (@5).h ]];
    NSSet *a2 = [NSSet setWithArray:@[ (@1).h, (@2).h, (@3).h, (@4).h, (@5).h ]];
    NSSet *a3 = [NSSet setWithArray:@[ (@9).h, (@7).h, (@3).h, (@4).h, (@5).h ]];
    NSSet *a4 = [NSSet setWithArray:@[ (@1).h, (@2).h, (@3).h, (@4).h ]];
    NSSet *a5 = [NSSet setWithArray:@[ (@5).h, (@4).h, (@3).h, (@2).h, (@1).h ]];
    
    XCTAssertEqual(SCObjectHash(a1), SCObjectHash(a2));
    XCTAssertNotEqual(SCObjectHash(a1), SCObjectHash(a3));
    XCTAssertNotEqual(SCObjectHash(a1), SCObjectHash(a4));
    XCTAssertEqual(SCObjectHash(a1), SCObjectHash(a5));
}

- (void)testNSOrderedSetHash {
    NSOrderedSet *a1 = [NSOrderedSet orderedSetWithArray:@[ (@1).h, (@2).h, (@3).h, (@4).h, (@5).h ]];
    NSOrderedSet *a2 = [NSOrderedSet orderedSetWithArray:@[ (@1).h, (@2).h, (@3).h, (@4).h, (@5).h ]];
    NSOrderedSet *a3 = [NSOrderedSet orderedSetWithArray:@[ (@9).h, (@7).h, (@3).h, (@4).h, (@5).h ]];
    NSOrderedSet *a4 = [NSOrderedSet orderedSetWithArray:@[ (@1).h, (@2).h, (@3).h, (@4).h ]];
    NSOrderedSet *a5 = [NSOrderedSet orderedSetWithArray:@[ (@5).h, (@4).h, (@3).h, (@2).h, (@1).h ]];
    
    XCTAssertEqual(SCObjectHash(a1), SCObjectHash(a2));
    XCTAssertNotEqual(SCObjectHash(a1), SCObjectHash(a3));
    XCTAssertNotEqual(SCObjectHash(a1), SCObjectHash(a4));
    XCTAssertNotEqual(SCObjectHash(a1), SCObjectHash(a5));
}

- (void)testStructHash {
    int i1 = 255;
    int i2 = 255;
    int i3 = 855;
    
    XCTAssertEqual(SCStructHash(i1), SCStructHash(i2));
    XCTAssertNotEqual(SCStructHash(i1), SCStructHash(i3));
    
    CGRect r1 = CGRectMake(0., 0., 200., 200.);
    CGRect r2 = CGRectMake(0., 0., 200., 200.);
    CGRect r3 = CGRectMake(5., 5., 195., 195.);
    
    XCTAssertEqual(SCStructHash(r1), SCStructHash(r2));
    XCTAssertNotEqual(SCStructHash(r1), SCStructHash(r3));
}

@end
