// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to APTag.m instead.

#import "_APTag.h"

const struct APTagAttributes APTagAttributes = {
	.name = @"name",
	.proxyForSorting = @"proxyForSorting",
};

const struct APTagRelationships APTagRelationships = {
	.bookTags = @"bookTags",
};

@implementation APTagID
@end

@implementation _APTag

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Tag";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:moc_];
}

- (APTagID*)objectID {
	return (APTagID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic proxyForSorting;

@dynamic bookTags;

- (NSMutableSet*)bookTagsSet {
	[self willAccessValueForKey:@"bookTags"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"bookTags"];

	[self didAccessValueForKey:@"bookTags"];
	return result;
}

@end

