//
//  APBookTableViewCell.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 26/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APBookTableViewCell.h"
#import "APBook.h"
#import "APCover.h"

@implementation APBookTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) configureCellWithBook:(APBook *)book{
    if(book.coverImage.imageData != nil){
        
    }
    
    self.nameBook.text = book.name;
    
}



@end
