// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to APBook.m instead.

#import "_APBook.h"

const struct APBookAttributes APBookAttributes = {
	.name = @"name",
	.urlImage = @"urlImage",
	.urlPDF = @"urlPDF",
};

const struct APBookRelationships APBookRelationships = {
	.annotation = @"annotation",
	.coverImage = @"coverImage",
	.pdfData = @"pdfData",
};

@implementation APBookID
@end

@implementation _APBook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Book";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Book" inManagedObjectContext:moc_];
}

- (APBookID*)objectID {
	return (APBookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic urlImage;

@dynamic urlPDF;

@dynamic annotation;

- (NSMutableSet*)annotationSet {
	[self willAccessValueForKey:@"annotation"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"annotation"];

	[self didAccessValueForKey:@"annotation"];
	return result;
}

@dynamic coverImage;

@dynamic pdfData;

@end

