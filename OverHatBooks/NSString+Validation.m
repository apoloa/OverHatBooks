//
//  NSString+Validation.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 31/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

+(BOOL)isEmpty:(NSString *)value{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return value == nil || value == (id)[NSNull null] || [value isEqualToString:@""] ||
    ([value respondsToSelector:@selector(length)] && [value length] == 0);
}

@end