//
//  APAnnotationsCollectionViewController.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 30/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APAnnotationsCollectionViewController.h"

static NSString *cellId = @"AnnotationCellId";

@interface APAnnotationsCollectionViewController ()

@end

@implementation APAnnotationsCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerCell];
    
    self.title = @"Annotations";
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - cell registration

-(void)registerCell{
    UINib *nib = [UINib nibWithNibName:@"APAnnotationCollectionViewCell" bundle:nil];
    
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:cellId];
}

@end
