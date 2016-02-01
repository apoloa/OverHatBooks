#import "_APAnnotation.h"
@import UIKit.UIImage;

@class APBook;

@interface APAnnotation : _APAnnotation {}
+ (instancetype)annotationOnBook:(APBook *)aBook
                       withTitle:(NSString *)aTitle
                            text:(NSString *)aText
                           photo:(UIImage *)aPhoto
                         context:(NSManagedObjectContext *)aContext;

-(NSArray *) arrayOfElements;
@end
