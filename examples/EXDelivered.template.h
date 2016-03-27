scribe(derive archivable)
@interface EXDelivered : EXBase

@property (nonatomic, readonly) NSData *customData;
@property (nonatomic, copy) NSString *author;

@end