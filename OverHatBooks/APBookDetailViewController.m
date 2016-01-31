//
//  APBookDetailViewController.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 30/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APBookDetailViewController.h"
#import "APAnnotationsCollectionViewController.h"
#import "APPDFBookViewController.h"
#import "UIImage+Color.h"
#import "APBook.h"
#import "APCover.h"
#import "APBookTag.h"
#import "APAnnotation.h"

@interface APBookDetailViewController ()

@end

@implementation APBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.book.coverImage.imageData != nil) {
        UIImage *img = [UIImage imageWithData:self.book.coverImage.imageData];
        self.image.image = img;
        //self.navigationController.navigationBar.barTintColor = [img averageColor];
    }
    self.title = self.book.name;
    self.nameBook.text = self.book.name;
    self.authorBook.text = [self.book authorsJoinedByString:@", "];
    self.tagsBook.text = [self.book tagsJoinedByString:@", "];
    [self configureShowAnnotations];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype) initWithBook:(APBook*) aBook{
    if(self = [super init]){
        _book = aBook;
    }
    return self;
}

-(void) configureShowAnnotations{
    if (!self.navigationItem.rightBarButtonItem){
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Annotations"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(showAnnotations)];
        self.navigationItem.rightBarButtonItem = button;
    }
}

-(void) showAnnotations{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:APAnnotation.entityName];
    
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:APAnnotationAttributes.name ascending:YES];
    
    req.sortDescriptors = @[nameSort];
    
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                         managedObjectContext:self.book.managedObjectContext
                                                                           sectionNameKeyPath:nil
                                                                                    cacheName:nil];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(120, 180);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    APAnnotationsCollectionViewController *annotationVC = [APAnnotationsCollectionViewController coreDataCollectionViewControllerWithFetchedResultsController:fc
                                                                                                                                                       layout:layout];
    
    [self.navigationController pushViewController:annotationVC animated:YES];
}
- (IBAction)readBook:(id)sender {
    APPDFBookViewController *pdfVC = [[APPDFBookViewController alloc] initWithBook:self.book];
    [self.navigationController pushViewController:pdfVC animated:YES];
}

@end
