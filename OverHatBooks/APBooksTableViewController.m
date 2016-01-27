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

@interface APBooksTableViewController ()

@end

@implementation APBooksTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"OverHatBooks";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    APBook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    [cell configureCellWithBook:nb];
    
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 122;
}


@end
