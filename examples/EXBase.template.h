#import "ExternalHeader.h"
// Comments, comments everywhere
scribe(default: implement nothing; synthesize properties=all, variables=all; extract interfaces=all)

scribe(implement mutable, builder; make abstract)
@interface EXBase
// Even here
scribe(implement validator=SomeValidatorInstance)
@property (nonatomic, readonly, nonnull, copy) /* or here */ NSString *Id;

scribe(implement validator=SomeValidatorInstance2, validator=SomeValidatorInstance3)
@property (nonatomic) NSString *name;

scribe(hint kind=boxed, primitive=NSInteger, wrap=numberWithInteger, unwrap=integerValue; synthesize primitive)
@property (nonatomic) NSNumber *counter;
@property (nonatomic) NSDictionary<NSString*,NSString*>*someArray;

@end
