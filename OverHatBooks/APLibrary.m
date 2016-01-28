//
//  APLibrary.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 27/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APLibrary.h"
#import "APBook.h"
#import "APCover.h"
#import "Settings.h"

@implementation APLibrary

# pragma mark - Init
-(id) initWithDatabaseName:(NSString *) name{
    if (self = [super init]) {
        self.model = [AGTCoreDataStack coreDataStackWithModelName:name];
    }
    
    return self;
}

-(void) importFromJSONData:(NSArray *)jsonDicts{
    [self.model zapAllData];
    
    for(NSDictionary *dict in jsonDicts){
        [APBook bookWithJSONDictionary:dict
                               context:self.model.context];
    }
    
    [self.model saveWithErrorBlock:^(NSError *error){
        NSLog(@"Error al guardar %@",error);
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def setBool:NO forKey:IS_LIBRARY_LOADED];
    }];
    
    
}

-(void) downloadCollectionFromUrl:(NSURL *)url{
    // First Configure NSURLSESSION
    NSURLSessionConfiguration *conf = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:url.path];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf
                                                          delegate:self
                                                     delegateQueue:nil];
    // Create NSURLSessionDownloadTask
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url];
    // Resume NSURLSessionDownloadTask
    [task resume];
}

# pragma mark - NSURLSession
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    // Convert to NSDATA
    NSData *data = [NSData dataWithContentsOfURL:location];
    // Serialize to JSON
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    // Send To convert to Books
    if (jsonObject &&
        [jsonObject isKindOfClass:[NSArray class]]){
        NSArray *books = (NSArray*)jsonObject;
        
        NSMutableArray *booksWithData = [NSMutableArray new];
        
        for(NSDictionary *dict in books){
            NSURL *url = [NSURL URLWithString:dict[@"image_url"]];
            NSMutableDictionary *dictWithData = [NSMutableDictionary dictionaryWithDictionary:dict];
            if (url != nil){
                NSData *dataImage = [NSData dataWithContentsOfURL:url];
                [dictWithData setObject:dataImage forKey:@"data_image"];
            }
            [booksWithData addObject:dictWithData];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self importFromJSONData:[booksWithData copy]];
        });
    }
    [session finishTasksAndInvalidate];
}

@end
