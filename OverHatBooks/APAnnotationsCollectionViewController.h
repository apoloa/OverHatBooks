//
//  APAnnotationsCollectionViewController.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 30/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "AGTCoreDataCollectionViewController.h"

@class APBook;

@interface APAnnotationsCollectionViewController : AGTCoreDataCollectionViewController

@property (nonatomic, strong) APBook *book;

@end
