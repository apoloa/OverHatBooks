#import "APBook.h"
#import "APCover.h"
#import "APPdfData.h"
#import "APAuthor.h"
#import "NSString+Tokenize.h"

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

+(instancetype) bookWithJSONDictionary:(NSDictionary *) dict
                               context:(NSManagedObjectContext *) context{
    APBook *b = [self insertInManagedObjectContext:context];
    b.name = dict[@"title"];
    b.urlImage = dict[@"image_url"];
    b.urlPDF = dict[@"pdf_url"];
    NSArray *arAuthors = [dict[@"authors"] tokenizeByCommas];
    NSMutableArray *arAPAuthors = [NSMutableArray new];
    for(NSString *authorName in arAuthors){
        [arAPAuthors addObject:[APAuthor authorWithName:authorName context:context]];
    }
    b.authors = [NSSet setWithArray:arAPAuthors];
    b.coverImage = [APCover insertInManagedObjectContext:context];
    b.coverImage.imageData = dict[@"data_image"];
    b.pdfData = [APPdfData insertInManagedObjectContext:context];
    
    return b;
}

@end
