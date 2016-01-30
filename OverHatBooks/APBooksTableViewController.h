//
//  APBooksTableViewController.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 27/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGTCoreDataTableViewController.h"

#define TAGS 0
#define ALPHABETICAL 1

@class APLibrary;

@interface APBooksTableViewController : AGTCoreDataTableViewController

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                               library:(APLibrary *)aLibrary
                                 style:(UITableViewStyle)aStyle;

@end
