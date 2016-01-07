#import "ExternalHeader.h"

@interface EXBase : NSObject
@implement mutable_copy

@property (nonatomic, readonly, nonnull, copy) NSString *Id;
@property (nonatomic) NSString *name;
@property (nonatomic) int counter;
@property (nonatomic) NSDictionary<NSString*,NSString*>*someArray;

@end