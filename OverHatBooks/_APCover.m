// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to APCover.m instead.

#import "_APCover.h"

const struct APCoverAttributes APCoverAttributes = {
	.imageData = @"imageData",
};

const struct APCoverRelationships APCoverRelationships = {
	.book = @"book",
};

@implementation APCoverID
@end

@implementation _APCover

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Cover" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Cover";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Cover" inManagedObjectContext:moc_];
}

- (APCoverID*)objectID {
	return (APCoverID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic imageData;

@dynamic book;

@end

