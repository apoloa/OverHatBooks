#import "APBook.h"
#import "APCover.h"
#import "APPdfData.h"
#import "APAuthor.h"
#import "APBookTag.h"
#import "APTag.h"
#import "NSString+Tokenize.h"
#import "Settings.h"

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

-(NSString *) tagsJoinedByStringWithoutFavorite:(NSString*)separator{
    NSArray *tags = [self.bookTags allObjects];
    NSMutableArray *tagsName = [NSMutableArray new];
    for(APBookTag *bookTag in tags){
        if(![bookTag.tag.name isEqualToString:FAVORITE_TAG]){
            [tagsName addObject:bookTag.tag.name];
        }
    }
    return [tagsName componentsJoinedByString:separator];
}

-(BOOL) isFavoriteBook{
    return ([[self tagsJoinedByString:@", "] rangeOfString:@"Favorite" options:NSCaseInsensitiveSearch].location == NSNotFound);
}

-(void) addFavoriteTag{
    [self addBookTagsObject:[APBookTag bookTagWithName:FAVORITE_TAG Book:self context:self.managedObjectContext]];
}
-(void) removeFavoriteTag{
    APBookTag *tagFavorite = nil;
    for (APBookTag *tag in self.bookTags) {
        if ([tag.tag.name isEqualToString:FAVORITE_TAG]){
            tagFavorite = tag;
            break;
        }
    }
    if(tagFavorite != nil){
        [self removeBookTagsObject:tagFavorite];
    }
}


@end
