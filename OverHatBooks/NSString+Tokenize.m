//
//  NSString+Tokenize.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 28/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "NSString+Tokenize.h"

@implementation NSString (Tokenize)

-(NSArray *) tokenizeByCommas{
    NSArray *tokens = [self componentsSeparatedByString:@","];
    NSMutableArray *clean = [NSMutableArray arrayWithCapacity:tokens.count];
    
    for (NSString *token in tokens) {
        [clean addObject:[token stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
    return clean;
}

@end
