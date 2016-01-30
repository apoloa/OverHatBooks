//
//  APBooksTableViewController.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 27/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APBooksTableViewController.h"
#import "APBookTableViewCell.h"
#import "APBook.h"
#import "APBookTag.h"
#import "APLibrary.h"
#import "Settings.h"



@interface APBooksTableViewController ()

@property (nonatomic, strong) APLibrary *library;
@property (nonatomic, assign) BOOL libraryLoaded;
@property (nonatomic, assign) BOOL currentOrder;

@end

@implementation APBooksTableViewController


#pragma mark - Init

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                               library:(APLibrary *)aLibrary
                                 style:(UITableViewStyle)aStyle{
    if (self == [super initWithFetchedResultsController:aFetchedResultsController style:aStyle]) {
        self.libraryLoaded = NO;
        self.currentOrder = TAGS;
        self.library = aLibrary;
        [self.library openWithCompletionHandler:^(NSError *err){
            self.libraryLoaded = YES;
            [self disableActivityIndicator];
            
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"OverHatBooks";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateRightButton];
    [self updateLeftSpinner];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"APBookCellId";
    
    
    APBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        // Creamos la celda de la nada
        [tableView registerNib:[UINib nibWithNibName:@"APBookTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    }
    
    // Averiguar que libro es
    APBook *nb = [self bookAtIndexPath:indexPath];
    
    
    [cell configureCellWithBook:nb];
    
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 122;
}


#pragma mark - Utils

- (APBookTag *)tagAtIndex:(NSIndexPath *)indexPath {
    APBookTag *tag = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return tag;
}

- (APBook *)bookAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *entityName = self.fetchedResultsController.fetchRequest.entityName;
    APBook *book;
    if ([entityName isEqualToString:[APBookTag entityName]]) {
        APBookTag *tag = [self tagAtIndex:indexPath];
        book = tag.book;
    } else if ([entityName isEqualToString:[APBook entityName]]) {
        book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }
    return book;
}

- (void)updateLeftSpinner{
    if(!self.navigationItem.leftBarButtonItem && self.libraryLoaded==NO){
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithCustomView:indicator];
        [indicator startAnimating];
        self.navigationItem.leftBarButtonItem = button;
    }
}

- (void)updateRightButton{
    //Add right button to navigator to change Book Order
    if (!self.navigationItem.rightBarButtonItem){
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(changeBooksOrder:)];
        self.navigationItem.rightBarButtonItem = button;
    }
    [self.navigationItem.rightBarButtonItem setTitle:(self.currentOrder == ALPHABETICAL)?@"Tags":@"Alphabetical"];
    
}


-(void)disableActivityIndicator{
    if(self.navigationItem.leftBarButtonItem){
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)changeBooksOrder:(id)sender
{
    NSFetchedResultsController *fc = nil;
    if (self.currentOrder == TAGS) {
        NSFetchRequest *r = [NSFetchRequest fetchRequestWithEntityName:APBook.entityName];
        r.fetchBatchSize = 20;
        
        NSSortDescriptor *bookName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        
        r.sortDescriptors = @[bookName];
        fc = [[NSFetchedResultsController alloc]
                                          initWithFetchRequest:r managedObjectContext:self.library.model.context
                                          sectionNameKeyPath:nil
                                          cacheName:nil];
        
        self.currentOrder = ALPHABETICAL;
    }else{
        NSFetchRequest *r = [NSFetchRequest fetchRequestWithEntityName:APBookTag.entityName];
        r.fetchBatchSize = 20;
        
        NSSortDescriptor *tagName = [NSSortDescriptor sortDescriptorWithKey:@"tag.name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        
        NSSortDescriptor *bookName = [NSSortDescriptor sortDescriptorWithKey:@"book.name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        
        r.sortDescriptors = @[tagName, bookName];
        fc = [[NSFetchedResultsController alloc]
                                          initWithFetchRequest:r managedObjectContext:self.library.model.context
                                          sectionNameKeyPath:@"tag.name"
                                          cacheName:nil];
        self.currentOrder = TAGS;

    }
    
    [self.navigationItem.rightBarButtonItem setTitle:(self.currentOrder == ALPHABETICAL)?@"Tags":@"Alphabetical"];
    self.fetchedResultsController = fc;
    [self.tableView reloadData];
    
}


@end
