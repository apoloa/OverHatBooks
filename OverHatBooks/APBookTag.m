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
/*
-(NSComparisonResult)compare:(APBookTag*)other{
 
    static NSString *fav = @"Favorite";
    if ([[self normalizedName] isEqualToString:[other normalizedName]]) { return NSOrderedSame;
    }else if ([[self normalizedName] isEqualToString:fav]){ return NSOrderedAscending;
    }else if ([[other normalizedName] isEqualToString:fav]){ return NSOrderedDescending;
    }else{
        return [self.name compare:other.normalizedName]; }
}
*/
@end
