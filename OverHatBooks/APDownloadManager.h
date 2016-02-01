//
//  APDownloadManager.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 01/02/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APDownloadDelegate.h"

@class APDownloadItem;

@interface APDownloadManager : NSObject

+ (instancetype)sharedInstance;

-(APDownloadItem *) containsTaskWithIdentifier:(NSString*)anIdentifier;

-(void) addNewTaskWithURL:(NSURL*)aUrl
                 delegate:(id<APDownloadDelegate>)aDelegate
               identifier:(NSString*)anIdentifier
          completionBlock:(void (^)(NSData * path, NSError *err))aCompletionBlock;

@end
