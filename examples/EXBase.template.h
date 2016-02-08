#import "ExternalHeader.h"
// Comments, comments everywhere
scribe(default: implement nothing)

scribe(implement mutable, builder; make abstract)
@interface EXBase : NSObject
// Even here
scribe(additional validate=SomeValidatorInstance)
@property (nonatomic, readonly, nonnull, copy) /* or here */ NSString *Id;

scribe(additional validate=SomeValidatorInstance2)
@property (nonatomic) NSString *name;
@property (nonatomic) int counter;
@property (nonatomic) NSDictionary<NSString*,NSString*>*someArray;

@end