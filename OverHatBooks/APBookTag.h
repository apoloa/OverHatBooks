#import "_APBookTag.h"

@class APBook;
@class APTag;

@interface APBookTag : _APBookTag {}
// Custom logic goes here.

+(instancetype) bookTagWithBook:(APBook*) book Tag:(APTag*)tag context:(NSManagedObjectContext*) context;

+(instancetype) bookTagWithName:(NSString*) name Book:(APBook*)book context:(NSManagedObjectContext*) context;
@end
