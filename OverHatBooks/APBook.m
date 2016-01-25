#import "APBook.h"

@interface APBook ()

// Private interface goes here.

@end

@implementation APBook

// Custom logic goes here.
+(instancetype) bookWithName:(NSString*) name
                        urlImage:(NSString *) image
                          urlPDF:(NSString *) pdf
                         context:(NSManagedObjectContext*) context{
    APBook *b = [self insertInManagedObjectContext:context];
    
    b.name = name;
    b.urlImage = image;
    b.urlPDF = pdf;
    
    return b;
    
}

@end
