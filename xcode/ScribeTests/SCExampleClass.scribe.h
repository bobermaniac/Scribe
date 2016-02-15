#import <Foundation/Foundation.h>
#import "Scribe.h"

scribe(implement mutable, builder, archivable, tracking)
@interface SCExampleClass : NSObject

scribe(implement validator=SCNonemptyStringValidator)
@property (nonatomic, strong, readonly, nonnull, getter=internalID) NSString * ID;
@property (nonatomic, strong, nullable, setter=applyObjectDescription:) NSString * objectDescription;

scribe(implement collection=component, validator=SCExampleArrayValidator)
@property (nonatomic, strong, nonnull) NSArray<NSString *> * components;
@property (nonatomic, assign) int counter;

@end

scribe(implement mutable, builder, archivable, tracking)
@interface SCExampleDeliveredClass : SCExampleClass

scribe(implement validator=SCNonnullValidator)
@property (nonatomic, strong, readonly) NSValue *additionalValue;

scribe(implement collection=number, validator=SCExampleArrayValidator)
@property (nonatomic, strong) NSDictionary<NSString *, NSNumber *> *tableOfNumbers;

@end

scribe(implement mutable)
@interface SCExampleSetContainer : NSObject

scribe(implement collection, validator=SCExampleArrayValidator)
@property (nonatomic, strong) NSSet *set;

@end