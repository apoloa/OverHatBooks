// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to APBookTag.h instead.

@import CoreData;
#import "APBaseManagedObject.h"

extern const struct APBookTagRelationships {
	__unsafe_unretained NSString *book;
	__unsafe_unretained NSString *tag;
} APBookTagRelationships;

@class APBook;
@class APTag;

@interface APBookTagID : NSManagedObjectID {}
@end

@interface _APBookTag : APBaseManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) APBookTagID* objectID;

@property (nonatomic, strong) APBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) APTag *tag;

//- (BOOL)validateTag:(id*)value_ error:(NSError**)error_;

@end

@interface _APBookTag (CoreDataGeneratedPrimitiveAccessors)

- (APBook*)primitiveBook;
- (void)setPrimitiveBook:(APBook*)value;

- (APTag*)primitiveTag;
- (void)setPrimitiveTag:(APTag*)value;

@end
