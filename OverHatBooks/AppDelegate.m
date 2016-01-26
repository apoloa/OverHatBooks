//
//  AppDelegate.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 24/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "AppDelegate.h"
#import "APBook.h"
#import "AGTCoreDataStack.h"
#import "APBooksViewControllers.h"

@interface AppDelegate ()

@property (strong, nonatomic) AGTCoreDataStack* model;

@end

@implementation AppDelegate


-(void) createDummyData{
    // Creo un libro
    
    APBook *b = [APBook bookWithName:@"Kamasutra"
                            urlImage:@"jajaj"
                              urlPDF:@"jojojo"
                             context:self.model.context];
    NSLog(@"%@", b);
    [self.model saveWithErrorBlock:^(NSError *error){
        NSLog(@"La Cagamos");
    }];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.model = [AGTCoreDataStack coreDataStackWithModelName:@"OverHatBooks"];
    
    // Meto datos chorras
    [self createDummyData];
    
    // Creamos la window y tal y cual
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    
    // NSFetchRequest
    NSFetchRequest *r = [NSFetchRequest fetchRequestWithEntityName:APBook.entityName];
    r.fetchBatchSize = 25;
    r.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:APBookAttributes.name
                                                        ascending:YES
                                                         selector:@selector(caseInsensitiveCompare:)]];
    
    // NSFetchedResultsController
    
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:r managedObjectContext:self.model.context
                                      sectionNameKeyPath:nil
                                      cacheName:nil];
    
    APBooksViewControllers *tVC = [[APBooksViewControllers alloc] initWithFetchedResultsController:fc style:UITableViewStylePlain];
    
    
    self.window.rootViewController = tVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
