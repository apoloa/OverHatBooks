#import "APPhoto.h"

@interface APPhoto ()

// Private interface goes here.

@end

@implementation APPhoto

- (UIImage *)image {
    
    // Convertir la NSData en UIImage
    return [UIImage imageWithData:self.imageData];
}

- (void)setImage:(UIImage *)image {
    
    // convertir la UIImage en NSData
    self.imageData = UIImageJPEGRepresentation(image, 0.9);
}

@end
