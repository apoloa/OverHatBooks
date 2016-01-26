//
//  APBooksViewControllers.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 26/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APBooksViewControllers.h"
#import "APBook.h"
@implementation APBooksViewControllers


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"NotebookCell";
    
    // Averiguar que libro es
    APBook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Crear la celda
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil){
        // Creamos la celda de la nada
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    // Sincronizar libro -> Celda
    cell.textLabel.text = nb.name;
    
    return cell;
}

@end
