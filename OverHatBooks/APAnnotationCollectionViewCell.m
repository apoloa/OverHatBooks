//
//  APAnnotationCollectionViewCell.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 30/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APAnnotationCollectionViewCell.h"
#import "APAnnotation.h"
#import "UIImage+Color.h"
#import "APPhoto.h"

@implementation APAnnotationCollectionViewCell

-(void) configureCellWithAnnotation:(APAnnotation *)aAnnotation{
    self.annotation = aAnnotation;
    self.titleAnnotation.text = aAnnotation.name;
    if (aAnnotation.photo.imageData) {
        self.imageAnnotation.hidden = false;
        self.imageAnnotation.image = aAnnotation.photo.image;
        self.backgroundColor = [self.imageAnnotation.image averageColor];
    }else{
        self.imageAnnotation.hidden = true;
        self.textAnnotation.text = aAnnotation.text;
    }
}

- (void)awakeFromNib {
    // Initialization code
    self.imageAnnotation.clipsToBounds = YES;
}

@end
