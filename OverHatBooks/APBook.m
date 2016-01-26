#import "APBook.h"
#import "APCover.h"
#import "APPdfData.h"

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
    b.coverImage = [APCover insertInManagedObjectContext:context];
    b.pdfData = [APPdfData insertInManagedObjectContext:context];
    
    return b;
    
}

@end
