// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to APPdfData.m instead.

#import "_APPdfData.h"

const struct APPdfDataAttributes APPdfDataAttributes = {
	.pdfData = @"pdfData",
};

const struct APPdfDataRelationships APPdfDataRelationships = {
	.book = @"book",
};

@implementation APPdfDataID
@end

@implementation _APPdfData

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PdfData" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PdfData";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PdfData" inManagedObjectContext:moc_];
}

- (APPdfDataID*)objectID {
	return (APPdfDataID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic pdfData;

@dynamic book;

@end

