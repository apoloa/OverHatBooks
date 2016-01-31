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

#import "UIViewController+Navigation.h"
#import "UIImage+Color.h"

@interface APPDFBookViewController ()
@property(nonatomic, strong) APBook *book;
@property (weak,nonatomic) IBOutlet KAProgressLabel * pLabel;
@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@end

@implementation APPDFBookViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if(self.book.pdfData.pdfData != nil){
        [self loadBook];
    }else{
        self.pdfViewer.hidden = YES;
        [self configureProgressLabel];
        NSURL *url = [NSURL URLWithString:self.book.urlPDF];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:self.book.name];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue new]];
        self.task = [session downloadTaskWithURL:url];
        [self.task resume];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addAnnotation)];
    self.navigationItem.rightBarButtonItem = add;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (!self.book.pdfData.pdfData) {
        [self.task cancel];
        
    }
}

-(id)initWithBook:(APBook*)aBook{
    if(self = [super init]){
        self.book = aBook;
    }
    return self;
}

-(void)addAnnotation{
    APAnnotationViewController *annotationVC = [[APAnnotationViewController alloc] initWithBook:self.book];
    
    [self presentViewController:[annotationVC wrappedInNavigation] animated:YES completion:nil];
}

-(void)loadBook{
    self.pdfViewer.hidden = NO;
    self.pLabel.hidden = true;
    [self.pdfViewer loadData:self.book.pdfData.pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:[NSURL new]];
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



- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.book.pdfData.pdfData = data;
        [self loadBook];
    });
    [session finishTasksAndInvalidate];
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    float bytesWrittenFloat = (float) totalBytesWritten;
    float totalBytesExprededToWriteFloat = (float) totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.pLabel setText:[NSString stringWithFormat:@"%0.0f", (bytesWrittenFloat/totalBytesExprededToWriteFloat)*100]];
        [self.pLabel setEndDegree:(bytesWrittenFloat/totalBytesExprededToWriteFloat)*360];
    });
}
@end
