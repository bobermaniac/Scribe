/* This class is generated by ObjCTemplar, please do not modify it */

#import "SCExampleClass.h"

@class SCExampleClass;


@protocol SCExampleDeliveredClass <SCExampleClass, NSCopying>


@end

@interface SCExampleDeliveredClass : SCExampleClass <SCExampleDeliveredClass> {
    @protected
 }

// Primary constructor
- (instancetype _Nullable)initWithID:(NSString * _Nonnull)ID error:(NSError * _Nullable __autoreleasing * _Nullable)error NS_DESIGNATED_INITIALIZER;

// Copy constructor
- (instancetype _Nonnull)initWithExampleClass:(SCExampleDeliveredClass * _Nonnull)exampleClass NS_DESIGNATED_INITIALIZER;


@end



