//
//  APAnnotationViewController.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 31/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APBook;
@class APAnnotation;

@interface APAnnotationViewController : UIViewController

-(id)initWithBook:(APBook *)aBook;
-(id)initWithAnnotation:(APAnnotation *)anAnnotation;


@property (weak, nonatomic) IBOutlet UITextField *titleAnnotation;
@property (weak, nonatomic) IBOutlet UITextView *textAnnotation;
@property (weak, nonatomic) IBOutlet UIImageView *imageAnnotation;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageActivityIndicator;

@end
