//
//  UIViewController+Navigation.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 26/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

-(UINavigationController *) wrappedInNavigation{
    // Create navigation controller
    
    UINavigationController *nav = [UINavigationController new];
    
    [nav pushViewController:self animated:NO];
    
    return nav;
}

@end
