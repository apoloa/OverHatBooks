// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to APBookTag.m instead.

#import "_APBookTag.h"

const struct APBookTagRelationships APBookTagRelationships = {
	.book = @"book",
	.tag = @"tag",
};

@implementation APBookTagID
@end

@implementation _APBookTag

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BookTag" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BookTag";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BookTag" inManagedObjectContext:moc_];
}

- (APBookTagID*)objectID {
	return (APBookTagID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic book;

@dynamic tag;

@end

