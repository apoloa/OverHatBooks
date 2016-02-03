//
//  APBaseManagedObject.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 28/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APBaseManagedObject.h"

@implementation APBaseManagedObject

# pragma mark - Init
+(id)uniqueObjectWithValue:(id)value forKey:(NSString *)key
    inManagedObjectContext:(NSManagedObjectContext *)context{
    // Nos aseguramos que el contexto no sea nil para evitar errores
    // chorras
    NSParameterAssert(context);
    // Buscamos un objeto que tenga el valor único para la propiedad
    // especificada
    NSFetchRequest *req = [NSFetchRequest
                           fetchRequestWithEntityName:[self entityName]];
    req.predicate = [NSPredicate predicateWithFormat:
                     [key stringByAppendingString:@" == %@"], value];
    req.fetchLimit = 1;
    // Hacemos la búsqueda
    NSError *err;
    NSArray *objs = [context executeFetchRequest:req
                                           error:&err];
    if (!objs) { // error
        NSLog(@"Error searching for %@s with a key = %@ and value = %@\n\n%@\n%@", [self entityName], key, value, err, err.userInfo );
        return nil;
    }
    NSManagedObject * obj = [objs lastObject];
    if (!obj) {
        // No habia nada y hay que crear
        obj = [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                            inManagedObjectContext:context];
        [obj setValue:value forKey:key];
    }
    
    return obj;
}

# pragma mark - Class Method
+ (NSString*)entityName {
    return @"";
}


+ (NSArray *) observableKeys{
    return @[];
}

#pragma mark - Life cycle

- (void)awakeFromInsert {
    [super awakeFromInsert];
    
    // Only once on life cycle
    [self setupKVO];
}

- (void)awakeFromFetch {
    [super awakeFromFetch];
    
    // n times on life cycle
    [self setupKVO];
}

- (void)willTurnIntoFault {
    [super willTurnIntoFault];
    
    // Before obj turns into fault
    [self tearDownKVO];
}

- (void)setupKVO {
    
    // Register for notification
    for (NSString *key in [[self class] observableKeys]) {
        [self addObserver:self
               forKeyPath:key
                  options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                  context:NULL];
    }
}

- (void)tearDownKVO {
    
    // Unregister for notifications
    for (NSString *key in [[self class] observableKeys]) {
        [self removeObserver:self forKeyPath:key];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
}

@end
