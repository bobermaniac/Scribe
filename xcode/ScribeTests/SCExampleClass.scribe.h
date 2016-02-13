#import <Foundation/Foundation.h>

scribe(implement mutable, builder, archivable, tracking)
@interface SCExampleClass : NSObject

scribe(implement validator=SCNonemptyStringValidator)
@property (nonatomic, strong, readonly, nonnull) NSString * ID;
@property (nonatomic, strong, nullable) NSString * objectDescription;
@property (nonatomic, strong, nonnull) NSArray<NSString *> * components;
@property (nonatomic, assign) int counter;

@end

scribe(implement mutable, builder, archivable, tracking)
@interface SCExampleDeliveredClass : SCExampleClass

scribe(implement validator=SCNonnullValidator)
@property (nonatomic, strong, readonly) NSValue *additionalValue;

@end