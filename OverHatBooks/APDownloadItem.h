//
//  APDownloadItem.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 01/02/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APDownloadDelegate.h"
#import "APCompleteTaskDelegate.h"

@interface APDownloadItem : NSObject

@property (nonatomic, strong) NSString *identifier;
@property float progress;
@property (nonatomic, weak) id<APDownloadDelegate> delegate;
@property (nonatomic, weak) id<APCompleteTaskDelegate> managerDelegate;

-(id) initWithIdentifier:(NSString* )anIdentifier
                delegate:(id<APDownloadDelegate>)aDelegate
         managerDelegate:(id<APCompleteTaskDelegate>)aManagerDelegate
         completionBlock:(void (^)(NSData * path, NSError *err))aCompletionBlock
                     url:(NSURL*)aUrl;


@end
