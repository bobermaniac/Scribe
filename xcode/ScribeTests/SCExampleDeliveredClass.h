/* This class is generated by ObjCTemplar, please do not modify it */

#import "SCExampleClass.h"

#import "SCTrackChanges.h"
#import "SCImmutableCopying.h"

@class SCExampleClass;
@class SCExampleSetContainer;
@class SCExampleDeliveredClassBuilder;

@protocol SCExampleDeliveredClass <SCExampleClass, NSCopying, SCImmutableCopying, NSMutableCopying, NSCoding>

@property (nonatomic, strong, readonly, retain) NSValue * _Nullable additionalValue;
@property (nonatomic, strong, retain, readonly) NSDictionary<NSString *, NSNumber *> * _Nullable tableOfNumbers;

@end

@interface SCExampleDeliveredClass : SCExampleClass <SCExampleDeliveredClass> {
    @protected
    NSValue * _Nullable _additionalValue;
    NSDictionary<NSString *, NSNumber *> * _Nullable _tableOfNumbers;
 }

- (instancetype _Nullable)initWithID:(NSString * _Nonnull)ID additionalValue:(NSValue * _Nullable)additionalValue  error:(NSError * _Nullable __autoreleasing * _Nullable)error NS_DESIGNATED_INITIALIZER;

- (instancetype _Nonnull)initWithExampleClass:(SCExampleDeliveredClass * _Nonnull)exampleClass NS_DESIGNATED_INITIALIZER;

// Builder support
+ (SCExampleDeliveredClassBuilder * _Nonnull)builder;

@end

@protocol SCMutableExampleDeliveredClass <SCExampleDeliveredClass, SCMutableExampleClass, SCTrackChanges>


@property (nonatomic, strong, setter=applyObjectDescription:, retain, readwrite) NSString * _Nullable objectDescription;

- (void)setComponents:(NSArray<NSString *> * _Nullable)components error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (void)addComponent:(NSString * _Nonnull)component error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (void)insertComponent:(NSString * _Nonnull)component atIndex:(NSUInteger)index error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (void)removeComponent:(NSString * _Nonnull)component error:(NSError * _Nullable __autoreleasing * _Nullable)error;

@property (nonatomic, assign, readwrite) int counter;

- (void)setTableOfNumbers:(NSDictionary<NSString *, NSNumber *> * _Nullable)tableOfNumbers error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (void)setNumber:(NSNumber * _Nonnull)number forKey:(NSString * _Nonnull)key error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (void)removeNumberForKey:(NSString * _Nonnull)key error:(NSError * _Nullable __autoreleasing * _Nullable)error;

@end

@interface SCMutableExampleDeliveredClass : SCExampleDeliveredClass <SCMutableExampleDeliveredClass>

@end

@interface SCExampleDeliveredClassBuilder : SCExampleClassBuilder

 @property (nonatomic, strong, readwrite, retain) NSValue * _Nullable additionalValue;
 @property (nonatomic, strong, retain, readwrite) NSDictionary<NSString *, NSNumber *> * _Nullable tableOfNumbers;

- (SCExampleDeliveredClass * _Nullable)buildWithError:(NSError * _Nullable __autoreleasing * _Nullable)error;

@end