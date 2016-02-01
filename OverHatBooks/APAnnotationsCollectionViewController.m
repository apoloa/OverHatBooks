//
//  APAnnotationsCollectionViewController.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 30/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APAnnotationsCollectionViewController.h"
#import "APAnnotation.h"
#import "APBook.h"
#import "APAnnotationCollectionViewCell.h"
#import "APAnnotationViewController.h"
#import "UIViewController+Navigation.h"

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

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    APAnnotation *annotation = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    APAnnotationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    
    gesture.minimumPressDuration = 1.0;
    [cell addGestureRecognizer:gesture];
    
    [cell configureCellWithAnnotation:annotation];
    return cell;
}

-(void) handleLongPress:(UILongPressGestureRecognizer *) gesture{
    APAnnotationCollectionViewCell *cell = (APAnnotationCollectionViewCell*) [gesture view];
    
    
        UIAlertController *actionCell = [UIAlertController alertControllerWithTitle:@"Do you want to...?"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *shareBtn = [UIAlertAction actionWithTitle:@"Share"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             [self displayActionsShare:cell.annotation];
                                                             
                                                         }];
        UIAlertAction *deleteBtn = [UIAlertAction actionWithTitle:@"Delete"
                                                             style:UIAlertActionStyleDestructive
                                                           handler:^(UIAlertAction * action) {
                                                               [self.book removeAnnotationObject:cell.annotation];
                                                               
                                                           }];
        UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"Cancel"
                                                            style: UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {
                                                              [actionCell dismissViewControllerAnimated:YES completion:nil];
                                                          }];
        [actionCell addAction:shareBtn];
        [actionCell addAction:deleteBtn];
        [actionCell addAction:cancelBtn];
        
        [self presentViewController:actionCell animated:YES completion:nil];
    
    
   
    
}

-(void) displayActionsShare:(APAnnotation *)annotation{
    
    UIActivityViewController * aVC = [[UIActivityViewController alloc] initWithActivityItems:[annotation arrayOfElements]applicationActivities:nil];
    [self presentViewController:aVC animated:YES completion:nil];
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    APAnnotation *annotation = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    APAnnotationViewController *annotationVC = [[APAnnotationViewController alloc] initWithAnnotation:annotation];
    [self.navigationController pushViewController:annotationVC animated:YES];
}

@end
