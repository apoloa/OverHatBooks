// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to APTag.h instead.

@import CoreData;
#import "APBaseManagedObject.h"

extern const struct APTagAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *proxyForSorting;
} APTagAttributes;

extern const struct APTagRelationships {
	__unsafe_unretained NSString *bookTags;
} APTagRelationships;

@class APBookTag;

@interface APTagID : NSManagedObjectID {}
@end

@interface _APTag : APBaseManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) APTagID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* proxyForSorting;

//- (BOOL)validateProxyForSorting:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *bookTags;

- (NSMutableSet*)bookTagsSet;

@end

@interface _APTag (BookTagsCoreDataGeneratedAccessors)
- (void)addBookTags:(NSSet*)value_;
- (void)removeBookTags:(NSSet*)value_;
- (void)addBookTagsObject:(APBookTag*)value_;
- (void)removeBookTagsObject:(APBookTag*)value_;

@end

@interface _APTag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveProxyForSorting;
- (void)setPrimitiveProxyForSorting:(NSString*)value;

- (NSMutableSet*)primitiveBookTags;
- (void)setPrimitiveBookTags:(NSMutableSet*)value;

@end
