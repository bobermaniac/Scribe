@interface EXDelivered : EXBase
@supports builder
@supports track_changes

@property (nonatomic, readonly) id customData;
@property (nonatomic, copy) NSString *author;

@end