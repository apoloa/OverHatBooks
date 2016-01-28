// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to APPdfData.h instead.

@import CoreData;
#import "APBaseManagedObject.h"

extern const struct APPdfDataAttributes {
	__unsafe_unretained NSString *pdfData;
} APPdfDataAttributes;

extern const struct APPdfDataRelationships {
	__unsafe_unretained NSString *book;
} APPdfDataRelationships;

@class APBook;

@interface APPdfDataID : NSManagedObjectID {}
@end

@interface _APPdfData : APBaseManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) APPdfDataID* objectID;

@property (nonatomic, strong) NSData* pdfData;

//- (BOOL)validatePdfData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) APBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _APPdfData (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePdfData;
- (void)setPrimitivePdfData:(NSData*)value;

- (APBook*)primitiveBook;
- (void)setPrimitiveBook:(APBook*)value;

@end
