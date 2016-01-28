//
//  APBookTableViewCell.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 26/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APBookTableViewCell.h"
#import "APBook.h"
#import "APAuthor.h"
#import "APCover.h"

@implementation APBookTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) configureCellWithBook:(APBook *)book{
    if(book.coverImage.imageData != nil){
        UIImage *img = [UIImage imageWithData:book.coverImage.imageData];
        self.coverBook.image = img;
    }
    NSArray *authors = [book.authors allObjects];
    NSMutableArray *authorsName = [NSMutableArray new];
    for(APAuthor *author in authors){
        [authorsName addObject:author.name];
    }
    NSString *authorsString = [authorsName componentsJoinedByString:@", "];
    
    
    self.authorBook.text = authorsString;
    self.nameBook.text = book.name;
}



@end
