//
//  APPDFBookViewController.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 30/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APPDFBookViewController.h"
#import "APAnnotationViewController.h"
#import "APBook.h"
#import "APCover.h"
#import "APPdfData.h"
#import "KAProgressLabel.h"

#import "APDownloadManager.h"
#import "APDownloadItem.h"
#import "APDownloadDelegate.h"

#import "UIViewController+Navigation.h"
#import "UIImage+Color.h"

static NSString *pdfIdentifier = @"pdfIdentifier";

@interface APPDFBookViewController () <APDownloadDelegate>
@property(nonatomic, strong) APBook *book;
@property (weak,nonatomic) IBOutlet KAProgressLabel * pLabel;
@end

@implementation APPDFBookViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addAnnotation)];
    self.navigationItem.rightBarButtonItem = add;
    
    if(self.book.pdfData.pdfData != nil){
        [self loadBook];
    }else{
        
        self.pdfViewer.hidden = YES;
        [self configureProgressLabel];
        
        APDownloadManager *downManager = [APDownloadManager sharedInstance];
        APDownloadItem *task = [downManager containsTaskWithIdentifier:self.book.name];
        if (task == nil) {
            //Download
            NSURL *url = [NSURL URLWithString:self.book.urlPDF];
            [downManager addNewTaskWithURL:url delegate:self identifier:self.book.name completionBlock:^(NSData *data, NSError *err) {
                if(err == nil){
                    self.book.pdfData.pdfData = data;
                    [self loadViewData:data];
                }
                
            }];
        }else{
            //ProgressDownload
            task.delegate = self;
            [self setProgress:task.progress];
        }
    }
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(id)initWithBook:(APBook*)aBook{
    if(self = [super init]){
        self.book = aBook;
    }
    return self;
}

-(void)addAnnotation{
    APAnnotationViewController *annotationVC = [[APAnnotationViewController alloc] initWithBook:self.book];
    
    [self.navigationController pushViewController:annotationVC animated:YES];
}

#pragma mark - Load PDF

-(void)loadViewData:(NSData*)data{
    self.pdfViewer.hidden = NO;
    self.pLabel.hidden = true;
    [self.pdfViewer loadData:data MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:[NSURL new]];
}


-(void)loadBook{
    self.pdfViewer.hidden = NO;
    self.pLabel.hidden = true;
    [self.pdfViewer loadData:self.book.pdfData.pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:[NSURL new]];
}

#pragma mark - KAProgress

-(void)setProgress:(float) progress{
    [self.pLabel setText:[NSString stringWithFormat:@"%0.0f", progress*100]];
    [self.pLabel setEndDegree:progress*360];
}

-(void)configureProgressLabel{
    [self.pLabel setProgressWidth:8.0f];
    self.pLabel.backgroundColor = [UIColor clearColor];
    [self.pLabel setTrackWidth: 0];
    [self.pLabel setStartDegree:0];
    [self.pLabel setRoundedCornersWidth:0];
    self.pLabel.fillColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.3];
    self.pLabel.trackColor = [UIColor redColor];
    self.pLabel.progressColor = self.book.coverImage.imageData != nil? [[UIImage imageWithData:self.book.coverImage.imageData ] averageColor]:[UIColor greenColor];
    self.pLabel.isStartDegreeUserInteractive = NO;
    self.pLabel.isEndDegreeUserInteractive = NO;
}

#pragma mark - APDownloadDelegate

-(void) bookDownloaded:(NSURL*)location{
   
    //[self loadBook];
}


-(void) BookDownloadProgress:(float)progress{
    [self setProgress:progress];
}



@end
