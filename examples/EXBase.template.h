#import "ExternalHeader.h"
// Comments, comments everywhere

scribe(implement mutable, builder, archivable; make abstract)
@interface EXBase
// Even here
scribe(implement validator=SomeValidatorInstance)
@property (nonatomic, readonly, nonnull, copy) /* or here */ NSString *Id;

scribe(implement validator=SomeValidatorInstance2, validator=SomeValidatorInstance3)
@property (nonatomic) NSString *name;

scribe(hint kind=boxed, primitive=NSInteger, wrap=numberWithInteger, unwrap=integerValue; synthesize primitive)
@property (nonatomic) NSNumber *counter;
@property (nonatomic) NSDictionary<NSString*,NSString*>*someArray;
@property (nonatomic) int count;
@property (nonatomic) NSInteger count2;

@end
