// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to APAuthor.h instead.

@import CoreData;

extern const struct APAuthorAttributes {
	__unsafe_unretained NSString *name;
} APAuthorAttributes;

extern const struct APAuthorRelationships {
	__unsafe_unretained NSString *books;
} APAuthorRelationships;

@class APBook;

@interface APAuthorID : NSManagedObjectID {}
@end

@interface _APAuthor : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) APAuthorID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _APAuthor (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(APBook*)value_;
- (void)removeBooksObject:(APBook*)value_;

@end

@interface _APAuthor (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
