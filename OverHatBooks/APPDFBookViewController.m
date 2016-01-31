//
//  APPDFBookViewController.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 30/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APPDFBookViewController.h"
#import "APBook.h"
#import "APPdfData.h"
#import "KAProgressLabel.h"

@interface APPDFBookViewController ()
@property(nonatomic, strong) APBook *book;
@property (weak,nonatomic) IBOutlet KAProgressLabel * pLabel;
@end

@implementation APPDFBookViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    if(self.book.pdfData.pdfData){
        [self loadBook];
    }else{
        self.pdfViewer.hidden = YES;
        [self.pLabel setProgressWidth:8.0f];
        self.pLabel.backgroundColor = [UIColor clearColor];
        [self.pLabel setTrackWidth: 0];
        [self.pLabel setStartDegree:0];
        [self.pLabel setRoundedCornersWidth:0];
        self.pLabel.fillColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.3];
        self.pLabel.trackColor = [UIColor redColor];
        self.pLabel.progressColor = [UIColor greenColor];
        self.pLabel.isStartDegreeUserInteractive = YES;
        self.pLabel.isEndDegreeUserInteractive = YES;
        NSURL *url = [NSURL URLWithString:self.book.urlPDF];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:self.book.name];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url];
        
        [task resume];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addAnnotation:)];
    self.navigationItem.rightBarButtonItem = add;
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype) initWithBook:(APBook*)aBook{
    if(self = [super init]){
        self.book = aBook;
    }
    return self;
}

-(void) addAnnotation{
    
}

-(void) loadBook{
    self.pdfViewer.hidden = NO;
    self.pLabel.hidden = true;
    [self.pdfViewer loadData:self.book.pdfData.pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:[NSURL new]];
}



- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.book.pdfData.pdfData = data;
        [self loadBook];
    });
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    float bytesWrittenFloat = (float) totalBytesWritten;
    float totalBytesExprededToWriteFloat = (float) totalBytesExpectedToWrite;
    NSLog(@"%f", bytesWrittenFloat/totalBytesExprededToWriteFloat);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.pLabel setText:[NSString stringWithFormat:@"%0.0f", (bytesWrittenFloat/totalBytesExprededToWriteFloat)*100]];
        [self.pLabel setEndDegree:(bytesWrittenFloat/totalBytesExprededToWriteFloat)*360];
    });
}
@end
