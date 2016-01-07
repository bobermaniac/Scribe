@interface EXDelivered : EXBase
@supports mutable_copy
@supports track_changes

@property (nonatomic, readonly) id customData;
@property (nonatomic, copy) NSString *author;

@end