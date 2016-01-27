//
//  APBookTableViewCell.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 26/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import <UIKit/UIKit.h>
@class APBook;

@interface APBookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverBook;
@property (weak, nonatomic) IBOutlet UILabel *nameBook;
@property (weak, nonatomic) IBOutlet UILabel *authorBook;
@property (weak, nonatomic) IBOutlet UIProgressView *progressDownload;


-(void) configureCellWithBook:(APBook *)book;

@end
