//
//  APDownloadManager.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 01/02/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APDownloadManager.h"
#import "APDownloadItem.h"
#import "APDownloadDelegate.h"
#import "APCompleteTaskDelegate.h"


@interface APDownloadManager() <APCompleteTaskDelegate>

@property (nonatomic, strong) NSMutableArray *elements;

@end

@implementation APDownloadManager

+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

-(APDownloadItem *) containsTaskWithIdentifier:(NSString*)anIdentifier{
    for(APDownloadItem *item in self.elements){
        if ([anIdentifier isEqualToString:item.identifier]) {
            return item;
        }
    }
    return nil;
}

-(void) addNewTaskWithURL:(NSURL*)aUrl
                 delegate:(id<APDownloadDelegate>)aDelegate
               identifier:(NSString*)anIdentifier
          completionBlock:(void (^)(NSData * path, NSError *err))aCompletionBlock{
    APDownloadItem *task = [[APDownloadItem alloc]initWithIdentifier:anIdentifier delegate:aDelegate managerDelegate:self completionBlock:aCompletionBlock url:aUrl];
    [self.elements addObject:task];
}

#pragma mark - APCompleteTaskDelegate

-(void) finishTask:(NSString*)identifier{
    APDownloadItem *item = [self containsTaskWithIdentifier:identifier];
    if (item != nil) {
        [self.elements removeObject:item];
    }
}


@end
