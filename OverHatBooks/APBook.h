#import "_APBook.h"

@interface APBook : _APBook {}
// Custom logic goes here.

+(instancetype) bookWithName:(NSString *) name
                    urlImage:(NSString *) image
                      urlPDF:(NSString *) pdf
                     context:(NSManagedObjectContext *) context;

+(instancetype) bookWithJSONDictionary:(NSDictionary *) dict
                               context:(NSManagedObjectContext *) context;
-(NSString *) authorsJoinedByString:(NSString*)separator;
-(NSString *) tagsJoinedByString:(NSString*)separator;

@end
