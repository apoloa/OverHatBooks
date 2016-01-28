#import "_APAuthor.h"

@interface APAuthor : _APAuthor {}
// Custom logic goes here.

+(instancetype) authorWithName:(NSString *)name
                       context:(NSManagedObjectContext *)context;

@end
