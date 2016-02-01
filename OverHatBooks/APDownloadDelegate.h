//
//  APDownloadDelegate.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 01/02/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APDownloadDelegate <NSObject>

-(void) bookDownloaded:(NSURL*)location;

@optional
-(void) BookDownloadProgress:(float)progress;

@end
