//
//  APPDFBookViewController.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 30/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APBook;

@interface APPDFBookViewController : UIViewController <NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *pdfViewer;

-(instancetype) initWithBook:(APBook*)aBook;

@end