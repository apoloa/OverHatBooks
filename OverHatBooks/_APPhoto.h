// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to APPhoto.h instead.

@import CoreData;
#import "APBaseManagedObject.h"

extern const struct APPhotoAttributes {
	__unsafe_unretained NSString *imageData;
} APPhotoAttributes;

extern const struct APPhotoRelationships {
	__unsafe_unretained NSString *annotations;
} APPhotoRelationships;

@class APAnnotation;

@interface APPhotoID : NSManagedObjectID {}
@end

@interface _APPhoto : APBaseManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) APPhotoID* objectID;

@property (nonatomic, strong) NSData* imageData;

//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *annotations;

- (NSMutableSet*)annotationsSet;

@end

@interface _APPhoto (AnnotationsCoreDataGeneratedAccessors)
- (void)addAnnotations:(NSSet*)value_;
- (void)removeAnnotations:(NSSet*)value_;
- (void)addAnnotationsObject:(APAnnotation*)value_;
- (void)removeAnnotationsObject:(APAnnotation*)value_;

@end

@interface _APPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (NSMutableSet*)primitiveAnnotations;
- (void)setPrimitiveAnnotations:(NSMutableSet*)value;

@end
