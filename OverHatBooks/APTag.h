#import "_APTag.h"

@interface APTag : _APTag {}
// Custom logic goes here.

+(instancetype) tagWithName:(NSString*) name context:(NSManagedObjectContext*) context;

@end
