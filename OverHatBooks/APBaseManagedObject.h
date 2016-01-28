//
//  APBaseManagedObject.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 28/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

@import CoreData;

@interface APBaseManagedObject : NSManagedObject

+(NSString*)entityName;

+(id)uniqueObjectWithValue:(id)value
                    forKey:(NSString *)key
    inManagedObjectContext:(NSManagedObjectContext *)context;

@end
