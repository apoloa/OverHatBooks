#import "APAnnotation.h"
#import "APBook.h"
#import "APPhoto.h"

@interface APAnnotation ()

// Private interface goes here.

@end

@implementation APAnnotation


#pragma mark - Init
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

#pragma mark - Utils
-(NSArray *) arrayOfElements{
    
    NSMutableArray *items = [NSMutableArray array];
    if (self.name) {
        [items addObject:self.name];
    }
    if(self.text){
        [items addObject:self.text];
    }
    if(self.photo.image){
        [items addObject:self.photo.image];
    }
    
    return items;
}

#pragma mark - KVO

+ (NSArray *) observableKeys{
    return @[APAnnotationRelationships.photo, APAnnotationAttributes.text, APAnnotationAttributes.name];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    self.modificationDate = [NSDate date];
}



@end
