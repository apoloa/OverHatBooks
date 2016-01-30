#import "APBook.h"
#import "APCover.h"
#import "APPdfData.h"
#import "APAuthor.h"
#import "APBookTag.h"
#import "APTag.h"
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
    for(NSString *authorName in arAuthors){
        [b addAuthorsObject:[APAuthor authorWithName:authorName context:context]];
    }
    NSArray *arTags = [dict[@"tags"] tokenizeByCommas];
    for(NSString *tagName in arTags){
        [b addBookTagsObject:[APBookTag bookTagWithName:tagName Book:b context:context]];
    }

    b.coverImage = [APCover insertInManagedObjectContext:context];
    b.coverImage.imageData = dict[@"data_image"];
    b.pdfData = [APPdfData insertInManagedObjectContext:context];
    
    return b;
}


-(NSString *) authorsJoinedByString:(NSString*)separator{
    NSArray *authors = [self.authors allObjects];
    NSMutableArray *authorsName = [NSMutableArray new];
    for(APAuthor *author in authors){
        [authorsName addObject:author.name];
    }
    return [authorsName componentsJoinedByString:separator];
}
-(NSString *) tagsJoinedByString:(NSString*)separator{
    NSArray *tags = [self.bookTags allObjects];
    NSMutableArray *tagsName = [NSMutableArray new];
    for(APBookTag *bookTag in tags){
        [tagsName addObject:bookTag.tag.name];
    }
    return [tagsName componentsJoinedByString:separator];
}



@end
