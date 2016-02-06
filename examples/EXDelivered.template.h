@interface EXDelivered : EXBase
@implement mutable_copy
@implement builder
@implement track_changes

@property (nonatomic, readonly) id customData;
@property (nonatomic, copy) NSString *author;

@end