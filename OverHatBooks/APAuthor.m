#import "APAuthor.h"

@interface APAuthor ()

// Private interface goes here.

@end

@implementation APAuthor

// Custom logic goes here.


+(instancetype) authorWithName:(NSString *)name
                       context:(NSManagedObjectContext *)context{
    APAuthor *author = [self uniqueObjectWithValue:[name capitalizedString]
                                            forKey:APAuthorAttributes.name
                            inManagedObjectContext:context];
    
    return author;
}

@end
