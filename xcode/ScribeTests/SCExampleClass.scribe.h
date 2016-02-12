#import <Foundation/Foundation.h>

scribe(implement mutable, builder, archivable, tracking)
@interface SCExampleClass : NSObject

scribe(implement validator=SCNonnullValidator)
@property (nonatomic, strong, readonly, nonnull) NSString * ID;
@property (nonatomic, strong, nullable) NSString * description;
@property (nonatomic, strong, nonnull) NSArray<NSString *> * components;

scribe(implement validator=SCNonnullValidator)
@property (nonatomic, assign) int counter;

@end

@interface SCExampleDeliveredClass : SCExampleClass

@end