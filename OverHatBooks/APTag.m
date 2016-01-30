#import "APTag.h"
#import "Settings.h"

@interface APTag ()

// Private interface goes here.

@end

@implementation APTag

+(instancetype) tagWithName:(NSString*) name context:(NSManagedObjectContext*) context{
    // BookTags should be unique, so we use the unique (findOrCreate)
    // method in our base class
    APTag *tag =  [self uniqueObjectWithValue:[name capitalizedString]
                                       forKey:APTagAttributes.name inManagedObjectContext:context];
    // proxyForComparison makes sure that Favorite always comes first // Uso KVC para saltarme la propiedad readOnly de proxyForSorting if ([tag.name isEqualToString:FAVORITE_TAG]) {
    if ([tag.name isEqualToString:FAVORITE_TAG]) {
        [tag setValue:[NSString stringWithFormat:@"__%@", tag.name] forKey:APTagAttributes.proxyForSorting];
    }else{
        [tag setValue:tag.name
               forKey:APTagAttributes.proxyForSorting];
    }
    return tag;
}

@end
