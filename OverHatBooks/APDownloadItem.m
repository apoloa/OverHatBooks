//
//  APDownloadItem.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 01/02/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APDownloadItem.h"
#import "APDownloadDelegate.h"
#import "APCompleteTaskDelegate.h"

@interface APDownloadItem () <NSURLSessionDownloadDelegate>
@property (nonatomic,copy)void (^completionBlock)(NSData * path, NSError *err);
@end

@implementation APDownloadItem

-(id) initWithIdentifier:(NSString* )anIdentifier
                delegate:(id<APDownloadDelegate>)aDelegate
         managerDelegate:(id<APCompleteTaskDelegate>)aManagerDelegate
         completionBlock:(void (^)(NSData * path, NSError *err))aCompletionBlock
                     url:(NSURL*)aUrl{
    if(self = [super init]){
        self.delegate = aDelegate;
        self.completionBlock = aCompletionBlock;
        self.managerDelegate = aManagerDelegate;
        self.identifier = anIdentifier;
        [self startDownload:aUrl];
    }
    return self;
}

-(void) startDownload:(NSURL *) url{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:self.identifier];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url];
    [task resume];
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSData *data = [NSData dataWithContentsOfURL:location];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.completionBlock(data,nil);
        [self.delegate bookDownloaded:location];
        [self.managerDelegate finishTask:self.identifier];
        
    });
    [session finishTasksAndInvalidate];
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    float bytesWrittenFloat = (float) totalBytesWritten;
    float totalBytesExprededToWriteFloat = (float) totalBytesExpectedToWrite;
    self.progress = (bytesWrittenFloat/totalBytesExprededToWriteFloat);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate BookDownloadProgress:self.progress];
    });
}

@end
