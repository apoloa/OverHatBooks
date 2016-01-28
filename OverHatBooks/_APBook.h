// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to APBook.h instead.

@import CoreData;
#import "APBaseManagedObject.h"

extern const struct APBookAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *urlImage;
	__unsafe_unretained NSString *urlPDF;
} APBookAttributes;

extern const struct APBookRelationships {
	__unsafe_unretained NSString *annotation;
	__unsafe_unretained NSString *authors;
	__unsafe_unretained NSString *coverImage;
	__unsafe_unretained NSString *pdfData;
} APBookRelationships;

@class APAnnotation;
@class APAuthor;
@class APCover;
@class APPdfData;

@interface APBookID : NSManagedObjectID {}
@end

@interface _APBook : APBaseManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) APBookID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* urlImage;

//- (BOOL)validateUrlImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* urlPDF;

//- (BOOL)validateUrlPDF:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *annotation;

- (NSMutableSet*)annotationSet;

@property (nonatomic, strong) NSSet *authors;

- (NSMutableSet*)authorsSet;

@property (nonatomic, strong) APCover *coverImage;

//- (BOOL)validateCoverImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) APPdfData *pdfData;

//- (BOOL)validatePdfData:(id*)value_ error:(NSError**)error_;

@end

@interface _APBook (AnnotationCoreDataGeneratedAccessors)
- (void)addAnnotation:(NSSet*)value_;
- (void)removeAnnotation:(NSSet*)value_;
- (void)addAnnotationObject:(APAnnotation*)value_;
- (void)removeAnnotationObject:(APAnnotation*)value_;

@end

@interface _APBook (AuthorsCoreDataGeneratedAccessors)
- (void)addAuthors:(NSSet*)value_;
- (void)removeAuthors:(NSSet*)value_;
- (void)addAuthorsObject:(APAuthor*)value_;
- (void)removeAuthorsObject:(APAuthor*)value_;

@end

@interface _APBook (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveUrlImage;
- (void)setPrimitiveUrlImage:(NSString*)value;

- (NSString*)primitiveUrlPDF;
- (void)setPrimitiveUrlPDF:(NSString*)value;

- (NSMutableSet*)primitiveAnnotation;
- (void)setPrimitiveAnnotation:(NSMutableSet*)value;

- (NSMutableSet*)primitiveAuthors;
- (void)setPrimitiveAuthors:(NSMutableSet*)value;

- (APCover*)primitiveCoverImage;
- (void)setPrimitiveCoverImage:(APCover*)value;

- (APPdfData*)primitivePdfData;
- (void)setPrimitivePdfData:(APPdfData*)value;

@end
