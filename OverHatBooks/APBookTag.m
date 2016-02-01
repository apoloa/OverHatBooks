#import "APBookTag.h"
#import "APTag.h"
#import "APBook.h"

@interface APBookTag ()

// Private interface goes here.

@end

@implementation APBookTag

// Custom logic goes here.
+(instancetype) bookTagWithBook:(APBook*) book Tag:(APTag*)tag context:(NSManagedObjectContext*) context{
    APBookTag *bookTag = [APBookTag insertInManagedObjectContext:context];
    bookTag.book = book;
    bookTag.tag = tag;
    
    return bookTag;
}

+(instancetype) bookTagWithName:(NSString*) name Book:(APBook*)book context:(NSManagedObjectContext*) context{
    APBookTag *bookTag = [APBookTag insertInManagedObjectContext:context];
    
    APTag *tag = [APTag tagWithName:name context:context];
    bookTag.tag = tag;
    bookTag.book = book;
    
    return bookTag;
}




@end
