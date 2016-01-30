//
//  APBookDetailViewController.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 30/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APBook;

@interface APBookDetailViewController : UIViewController

@property (nonatomic, readonly) APBook *book;

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *nameBook;
@property (weak, nonatomic) IBOutlet UILabel *authorBook;
@property (weak, nonatomic) IBOutlet UILabel *tagsBook;
@property (weak, nonatomic) IBOutlet UISwitch *favoriteBook;

-(instancetype) initWithBook:(APBook*) aBook;

@end
