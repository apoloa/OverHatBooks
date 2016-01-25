#import "_APBook.h"

@interface APBook : _APBook {}
// Custom logic goes here.

+(instancetype) bookWithName:(NSString*) name
                    urlImage:(NSString *) image
                      urlPDF:(NSString *) pdf
                     context:(NSManagedObjectContext*) context;

@end
