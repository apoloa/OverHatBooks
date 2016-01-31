#import "APAnnotation.h"
#import "APBook.h"
#import "APPhoto.h"

@interface APAnnotation ()

// Private interface goes here.

@end

@implementation APAnnotation

+ (instancetype)annotationOnBook:(APBook *)aBook
                       withTitle:(NSString *)aTitle
                            text:(NSString *)aText
                           photo:(UIImage *)aPhoto
                         context:(NSManagedObjectContext *)aContext{
    APAnnotation *annotation = [self insertInManagedObjectContext:aContext];
    annotation.name = aTitle;
    annotation.text = aText;
    annotation.photo = [APPhoto insertInManagedObjectContext:aContext];
    if (aPhoto != nil) {
        annotation.photo.image = aPhoto;
    }
    annotation.creationDate = [NSDate date];
    annotation.modificationDate = annotation.creationDate;
    
    return annotation;
}
@end
