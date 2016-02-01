//
//  APCompleteTaskDelegate.h
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 01/02/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APCompleteTaskDelegate <NSObject>

-(void) finishTask:(NSString*)identifier;

@end
