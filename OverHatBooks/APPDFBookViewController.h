//
//  APPDFBookViewController.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 30/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APBook;

@interface APPDFBookViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *pdfViewer;

-(id)initWithBook:(APBook*)aBook;

@end
