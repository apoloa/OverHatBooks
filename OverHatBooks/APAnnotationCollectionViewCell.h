//
//  APAnnotationCollectionViewCell.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 30/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APAnnotation;

@interface APAnnotationCollectionViewCell : UICollectionViewCell

-(void) configureCellWithAnnotation:(APAnnotation *)aAnnotation;
@property (weak, nonatomic) IBOutlet UILabel *titleAnnotation;
@property (weak, nonatomic) IBOutlet UIImageView *imageAnnotation;
@property (weak, nonatomic) IBOutlet UITextView *textAnnotation;

@end
