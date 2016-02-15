scribe(implement archivable)
@interface EXDelivered : EXBase

@property (nonatomic, readonly) id customData;
@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) dispatch_block_t customBlock;

@end