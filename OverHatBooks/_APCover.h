// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to APCover.h instead.

@import CoreData;

extern const struct APCoverAttributes {
	__unsafe_unretained NSString *imageData;
} APCoverAttributes;

extern const struct APCoverRelationships {
	__unsafe_unretained NSString *book;
} APCoverRelationships;

@class APBook;

@interface APCoverID : NSManagedObjectID {}
@end

@interface _APCover : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) APCoverID* objectID;

@property (nonatomic, strong) NSData* imageData;

//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) APBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _APCover (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (APBook*)primitiveBook;
- (void)setPrimitiveBook:(APBook*)value;

@end
