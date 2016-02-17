//
//  SCValidatorTests.m
//  Scribe
//
//  Created by Victor Bryksin on 17/02/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Scribe/Scribe.h>

@interface SCValidatorTests : XCTestCase

@end

@implementation SCValidatorTests

- (void)testNonnullValidator {
    id<SCValidator> validator = [SCNonnullValidator validator];
    __kindof NSError *error = nil;
    
    NSString *str = @"String";
    XCTAssertTrue([validator validateValue:str ofProperty:@"p" forObject:nil error:&error]);
    XCTAssertNil(error);
    
    validator = [SCNonnullValidator validator];
    str = nil;
    XCTAssertFalse([validator validateValue:str ofProperty:@"p" forObject:nil error:&error]);
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, SCValidationErrorDomain);
    XCTAssertEqual(error.code, SCValidationFailedErrorCode);
    XCTAssertTrue([error isKindOfClass:[SCValidationError class]]);
    
    SCValidationError *validationError = error;
    XCTAssertEqual(validator, validationError.validator);
}

- (void)testNonemptyStringValidator {
    id<SCValidator> validator = [SCNonemptyStringValidator validator];
    __kindof NSError *error = nil;
    
    NSString *str = @"String";
    XCTAssertTrue([validator validateValue:str ofProperty:@"p" forObject:nil error:&error]);
    XCTAssertNil(error);
    
    validator = [SCNonemptyStringValidator validator];
    str = @"";
    XCTAssertFalse([validator validateValue:str ofProperty:@"p" forObject:nil error:&error]);
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, SCValidationErrorDomain);
    XCTAssertEqual(error.code, SCValidationFailedErrorCode);
    XCTAssertTrue([error isKindOfClass:[SCValidationError class]]);
    
    SCValidationError *validationError = error;
    XCTAssertEqual(validator, validationError.validator);
    
    validator = [SCNonemptyStringValidator validator];
    str = nil;
    XCTAssertFalse([validator validateValue:str ofProperty:@"p" forObject:nil error:&error]);
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, SCValidationErrorDomain);
    XCTAssertEqual(error.code, SCValidationFailedErrorCode);
    XCTAssertTrue([error isKindOfClass:[SCValidationError class]]);
    
    validationError = error;
    XCTAssertEqual(validator, validationError.validator);
    
    validator = [SCNonemptyStringValidator validator];
    NSNumber *number = @5;
    XCTAssertFalse([validator validateValue:number ofProperty:@"p" forObject:nil error:&error]);
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, SCValidationErrorDomain);
    XCTAssertEqual(error.code, SCInvalidTypeErrorCode);
    XCTAssertTrue([error isKindOfClass:[SCValidationError class]]);
    
    validationError = error;
    XCTAssertEqual(validator, validationError.validator);
}

@end
