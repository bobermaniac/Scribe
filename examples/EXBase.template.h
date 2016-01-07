@interface EXBase : NSObject
@supports mutable_copy

@property (nonatomic, immutable, nonnull, copy) NSString *Id;
@property (nonatomic) NSString *name;
@property (nonatomic) int counter;

@end