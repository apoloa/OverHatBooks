//
//  APLibrary.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 27/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGTCoreDataStack.h"

@interface APLibrary : NSObject

@property (strong, nonatomic) AGTCoreDataStack* model;

-(void) openWithCompletionHandler:(void (^)(NSError *))completionBlock;

-(id) initWithDatabaseName:(NSString *) name;

@end
