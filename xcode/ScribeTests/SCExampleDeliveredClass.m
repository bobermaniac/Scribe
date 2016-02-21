/* This class is generated by ObjCTemplar, please do not modify it */


#import "SCExampleDeliveredClass.h"
#import "SCValidator.h"
#import "SCImmutableCopyingHelpers.h"
#import "SCPropertyChangesTracker.h"
#import "SCExampleClass.h"
#import "SCExampleSetContainer.h"

#import "SCNonemptyStringValidator.h"
#import "SCExampleArrayValidator.h"
#import "SCNonnullValidator.h"

@interface SCExampleDeliveredClass () {
    @protected
    NSUInteger _SC_hash;
}

- (instancetype)initWithBuilder:(SCExampleDeliveredClassBuilder *)builder error:(NSError **)error;
+ (BOOL)_validateID:(NSString *)ID forObject:(SCExampleDeliveredClass *)object error:(NSError **)error;
+ (BOOL)_validateComponents:(NSArray<NSString *> *)components forObject:(SCExampleDeliveredClass *)object error:(NSError **)error;
+ (BOOL)_validateAdditionalValue:(NSValue *)additionalValue forObject:(SCExampleDeliveredClass *)object error:(NSError **)error;
+ (BOOL)_validateTableOfNumbers:(NSDictionary<NSString *, NSNumber *> *)tableOfNumbers forObject:(SCExampleDeliveredClass *)object error:(NSError **)error;

@end

@implementation SCExampleDeliveredClass

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithID:(NSString * _Nonnull)ID  error:(NSError **)error {
    NSAssert(NO, @"Forbidden");
    @throw [NSException exceptionWithName:@"Forbidden" reason:@"This object have its own immutable fields" userInfo:nil];
}
#pragma clang diagnostic pop

- (instancetype)initWithID:(NSString * _Nonnull)ID additionalValue:(NSValue * _Nullable)additionalValue error:(NSError **)error  {
    
    if (![SCExampleDeliveredClass _validateID:ID forObject:nil error:error]) { return nil; }
    if (![SCExampleDeliveredClass _validateAdditionalValue:additionalValue forObject:nil error:error]) { return nil; }
    
    if (self = [super initWithID:ID error:error]) { 
        _additionalValue = additionalValue;
    }

    NSAssert(self != nil, @"Internal error: object was not created");
    return self;
}

- (instancetype)initWithExampleClass:(SCExampleDeliveredClass * _Nonnull)exampleClass  {
    NSError * __autoreleasing e = nil, * __autoreleasing * error = &e;
    NSParameterAssert(exampleClass != nil);

    if (self = [super initWithExampleClass:exampleClass]) { 
        _additionalValue = exampleClass->_additionalValue;
        _tableOfNumbers = SCObjectImmutableCopy(exampleClass->_tableOfNumbers, error);
    }

    NSAssert(e == nil, @"Internal error: error flag was set");
    NSAssert(self != nil, @"Internal error: object was not created");
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)decoder {
    NSError *error = nil;
    
    NSString *ID = [decoder decodeObjectForKey:@"ID"];
    
    NSValue *additionalValue = [decoder decodeObjectForKey:@"additionalValue"];
    
    if (self = [self initWithID:ID additionalValue:additionalValue error:&error]) {
        _objectDescription = [decoder decodeObjectForKey:@"objectDescription"];
        _components = [decoder decodeObjectForKey:@"components"];
        _counter = [decoder decodeIntForKey:@"counter"];
        _tableOfNumbers = [decoder decodeObjectForKey:@"tableOfNumbers"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_ID forKey:@"ID"];
    [encoder encodeObject:_objectDescription forKey:@"objectDescription"];
    [encoder encodeObject:_components forKey:@"components"];
    [encoder encodeInt:_counter forKey:@"counter"];
    [encoder encodeObject:_additionalValue forKey:@"additionalValue"];
    [encoder encodeObject:_tableOfNumbers forKey:@"tableOfNumbers"];
    
}



- (instancetype _Nonnull)initWithBuilder:(SCExampleDeliveredClassBuilder * _Nonnull)builder error:(NSError **)error  {
    
    NSParameterAssert(builder != nil);
    if (![SCExampleDeliveredClass _validateID:builder.ID forObject:nil error:error]) { return nil; }
    if (![SCExampleDeliveredClass _validateAdditionalValue:builder.additionalValue forObject:nil error:error]) { return nil; }
    
    if (self = [self initWithID:builder.ID additionalValue:builder.additionalValue error:error]) { 
        _objectDescription = SCObjectImmutableCopy(builder.objectDescription, error);
        _components = SCObjectImmutableCopy(builder.components, error);
        _counter = builder.counter;
        _tableOfNumbers = SCObjectImmutableCopy(builder.tableOfNumbers, error);
    }

    NSAssert(self != nil, @"Internal error: object was not created");
    return self;
}

+ (SCExampleDeliveredClassBuilder * _Nonnull)builder {
    SCExampleDeliveredClassBuilder *builder = [[SCExampleDeliveredClassBuilder alloc] init];

    NSAssert(builder != nil, @"Internal error: builder was not created");
    return builder;
}


- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (BOOL)isImmutable {
    return YES;
}

- (id)immutableCopyWithError:(NSError **)error {
    SCExampleDeliveredClass *exampleClass = self;
    return [[SCExampleDeliveredClass alloc] initWithExampleClass:exampleClass];
}

- (NSUInteger)SC_hash {
    if (!_SC_hash) {
        _SC_hash = SCEnumerableHash(@[
            _ID ?: [NSNull null],
            _objectDescription ?: [NSNull null],
            _components ?: [NSNull null],
            @(_counter) ?: [NSNull null],
            _additionalValue ?: [NSNull null],
            _tableOfNumbers ?: [NSNull null],
            ], YES);
    }
    return _SC_hash;
}

- (NSUInteger)hash {
    return self.SC_hash;
}


- (id)mutableCopyWithZone:(NSZone *)zone {
    SCExampleDeliveredClass *exampleClass = self;
    exampleClass = [[SCMutableExampleDeliveredClass allocWithZone:zone] initWithExampleClass:exampleClass];

    NSAssert(exampleClass != nil, @"Internal error: object was not copied");
    return exampleClass;
} 

+ (BOOL)_validateID:(NSString *)ID forObject:(SCExampleDeliveredClass *)object error:(NSError **)error {
    for (NSObject<SCValidator> *validator in @[ [[SCNonemptyStringValidator alloc] init],  ]) {
        if (![validator validateValue:ID ofProperty:@"ID" forObject:object error:error]) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)_validateComponents:(NSArray<NSString *> *)components forObject:(SCExampleDeliveredClass *)object error:(NSError **)error {
    for (NSObject<SCValidator> *validator in @[ [[SCExampleArrayValidator alloc] init],  ]) {
        if (![validator validateValue:components ofProperty:@"components" forObject:object error:error]) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)_validateAdditionalValue:(NSValue *)additionalValue forObject:(SCExampleDeliveredClass *)object error:(NSError **)error {
    for (NSObject<SCValidator> *validator in @[ [[SCNonnullValidator alloc] init],  ]) {
        if (![validator validateValue:additionalValue ofProperty:@"additionalValue" forObject:object error:error]) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)_validateTableOfNumbers:(NSDictionary<NSString *, NSNumber *> *)tableOfNumbers forObject:(SCExampleDeliveredClass *)object error:(NSError **)error {
    for (NSObject<SCValidator> *validator in @[ [[SCExampleArrayValidator alloc] init],  ]) {
        if (![validator validateValue:tableOfNumbers ofProperty:@"tableOfNumbers" forObject:object error:error]) {
            return NO;
        }
    }
    return YES;
}



@dynamic additionalValue;

- (NSValue * _Nullable)additionalValue {
    return _additionalValue;
}

@dynamic tableOfNumbers;

- (NSDictionary<NSString *, NSNumber *> * _Nullable)tableOfNumbers {
    return _tableOfNumbers;
}

@end


@interface SCMutableExampleDeliveredClass () {
    NSObject<SCTracking> * _Nonnull _tracker;
}

@end

@implementation SCMutableExampleDeliveredClass

- (instancetype)initWithID:(NSString * _Nonnull)ID additionalValue:(NSValue * _Nullable)additionalValue  error:(NSError **)error  {
    if (self = [super initWithID:ID additionalValue:additionalValue  error:error]) {
        _tracker = [SCPropertyChangesTracker trackerWithTrackingObject:self mode:SCPropertyChangesTrackerManualMode];
    }

    NSAssert(self != nil, @"Internal error: object was not created");
    return self;
}

- (instancetype)initWithExampleClass:(SCExampleDeliveredClass * _Nonnull)exampleClass  {
    NSParameterAssert(exampleClass != nil);

    if (self = [super initWithExampleClass:exampleClass]) {
        if ([exampleClass isKindOfClass:[SCMutableExampleDeliveredClass class]]) {
            _tracker = [((SCMutableExampleDeliveredClass *)exampleClass)->_tracker copy];
        } else {
            _tracker = [SCPropertyChangesTracker trackerWithTrackingObject:self mode:SCPropertyChangesTrackerManualMode];
        }
    }

    NSAssert(self != nil, @"Internal error: object was not created");
    return self;
}

- (id<SCTracker>)changesTracker {
    return _tracker;
}


- (id)copyWithZone:(NSZone *)zone {
    SCMutableExampleDeliveredClass *exampleClass = self;
    return [[SCMutableExampleDeliveredClass allocWithZone:zone] initWithExampleClass:exampleClass];
}

- (BOOL)isImmutable {
    return NO;
}

@dynamic objectDescription;

- (void)applyObjectDescription:(NSString * _Nullable)objectDescription {
    
    if (![_objectDescription isEqual:objectDescription]) {
        [_tracker property:@"objectDescription" beforeChangeValue:_objectDescription];
        [self willChangeValueForKey:@"objectDescription"];
        _objectDescription = objectDescription;
        _SC_hash = 0;
        [self didChangeValueForKey:@"objectDescription"];
        [_tracker property:@"objectDescription" afterChangeValue:_objectDescription];
    }
}



@dynamic components;

- (void)setComponents:(NSArray<NSString *> * _Nullable)components error:(NSError **)error{
    if (![SCExampleDeliveredClass _validateComponents:components forObject:self error:error]) { return; }
    
    if (![_components isEqual:components]) {
        [_tracker property:@"components" beforeChangeValue:_components];
        [self willChangeValueForKey:@"components"];
        _components = components;
        _SC_hash = 0;
        [self didChangeValueForKey:@"components"];
        [_tracker property:@"components" afterChangeValue:_components];
    }
}



- (void)addComponent:(NSString *)component error:(NSError **)error {
    NSMutableArray *components = [self.components mutableCopy] ?: [NSMutableArray array];
    [components addObject:component];
    [self setComponents:components error:error];
}

- (void)insertComponent:(NSString *)component atIndex:(NSUInteger)index error:(NSError **)error {
    NSMutableArray *components = [self.components mutableCopy] ?: [NSMutableArray array];
    [components insertObject:component atIndex:index];
    [self setComponents:components error:error];
}

- (void)removeComponent:(NSString *)component error:(NSError **)error {
    NSMutableArray *components = [self.components mutableCopy];
    [components removeObject:component];
    [self setComponents:components error:error];
}



@dynamic counter;

- (void)setCounter:(int)counter {
    
    if (_counter != counter) {
        [_tracker property:@"counter" beforeChangeValue:@(_counter)];
        [self willChangeValueForKey:@"counter"];
        _counter = counter;
        _SC_hash = 0;
        [self didChangeValueForKey:@"counter"];
        [_tracker property:@"counter" afterChangeValue:@(_counter)];
    }
}



@dynamic tableOfNumbers;

- (void)setTableOfNumbers:(NSDictionary<NSString *, NSNumber *> * _Nullable)tableOfNumbers error:(NSError **)error{
    if (![SCExampleDeliveredClass _validateTableOfNumbers:tableOfNumbers forObject:self error:error]) { return; }
    
    if (![_tableOfNumbers isEqual:tableOfNumbers]) {
        [_tracker property:@"tableOfNumbers" beforeChangeValue:_tableOfNumbers];
        [self willChangeValueForKey:@"tableOfNumbers"];
        _tableOfNumbers = tableOfNumbers;
        _SC_hash = 0;
        [self didChangeValueForKey:@"tableOfNumbers"];
        [_tracker property:@"tableOfNumbers" afterChangeValue:_tableOfNumbers];
    }
}



- (void)setNumber:(NSNumber *)number forKey:(NSString *)key error:(NSError **)error {
    NSMutableDictionary *tableOfNumbers = [self.tableOfNumbers mutableCopy] ?: [NSMutableDictionary dictionary];
    [tableOfNumbers setObject:number forKey:key];
    [self setTableOfNumbers:tableOfNumbers error:error];
}

- (void)removeNumberForKey:(NSString *)key error:(NSError **)error {
    NSMutableDictionary *tableOfNumbers = [self.tableOfNumbers mutableCopy];
    [tableOfNumbers removeObjectForKey:key];
    [self setTableOfNumbers:tableOfNumbers error:error];
}



@end



@implementation SCExampleDeliveredClassBuilder

@synthesize additionalValue = _additionalValue;

@synthesize tableOfNumbers = _tableOfNumbers;

- (SCExampleDeliveredClass *)buildWithError:(NSError **)error {
    return [[SCExampleDeliveredClass alloc] initWithBuilder:self error:error];
}

@end
