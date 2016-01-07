@interface EXDelivered : EXBase
@supports mutable_copy
@supports track_changes

@property (nonatomic, immutable) id customData;
@property (nonatomic, copy) NSString *author;

@end