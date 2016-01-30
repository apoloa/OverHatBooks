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


-(void) openWithCompletionHandler:(void (^)(NSError *))completionBlock{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSError __block *openingError = nil;
    // download & import if necessary
    if (![def boolForKey:IS_LIBRARY_LOADED]) {
        [self downloadJSONWithContinuationBlock:^(NSError *err, NSArray *jsonDicts) {
            
            if (!err) {
                // No error, so init the stack and then import
                [self importFromJSONData:jsonDicts];
                [def setBool:YES forKey:IS_LIBRARY_LOADED];
            }else{
                
                openingError = err;
            }
            completionBlock(openingError);
        }];
        
    }else{
        completionBlock(openingError);
    }
}


-(void) downloadJSONWithContinuationBlock:(void (^)(NSError *, NSArray *))continuationBlock{
    
    dispatch_queue_t queue = dispatch_queue_create("Download Queue",NULL);
    
    dispatch_async(queue, ^{
        // Perform long running process
        NSURL *url = [NSURL URLWithString:URL_BOOKS];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSError __block *error = nil;
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
            
            NSArray *arBooks = [booksWithData copy];
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                continuationBlock(error, arBooks);
            });
        }
    });
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
