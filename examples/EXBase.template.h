#import "ExternalHeader.h"
// Comments, comments everywhere

scribe(implement mutable=Mut, builder=Bldr; make abstract)
@interface EXBase : NSObject
@implement mutable_copy
@implement abstract

// Even here
@property (nonatomic, readonly, nonnull, copy) /* or here */ NSString *Id;
@property (nonatomic) NSString *name;
@property (nonatomic) int counter;
@property (nonatomic) NSDictionary<NSString*,NSString*>*someArray;

@end