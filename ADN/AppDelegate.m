//
//  AppDelegate.m
//  ADN
//
//  Created by Le Ngoc Duy on 11/19/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "AppDelegate.h"
#import <RKManagedObjectStore.h>
#import <RKObjectManager.h>

@implementation AppDelegate

- (void)setupReskit
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    // Initialize RestKit
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:BASE_URL_SERVER]];
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore  alloc] initWithManagedObjectModel:managedObjectModel];
    manager.managedObjectStore = managedObjectStore;
    
    /**
     Complete Core Data stack initialization
     */
    [managedObjectStore createPersistentStoreCoordinator];
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"CoreDataMovie.sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:nil  withConfiguration:nil options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES} error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    [[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    
    [RKMIMETypeSerialization registerClass:[RKXMLReaderSerialization class] forMIMEType:@"text/html"];
    [[RKObjectManager sharedManager] setAcceptHeaderWithMIMEType:@"text/html"];
    
//    [[RKObjectManager sharedManager] addFetchRequestBlock:^NSFetchRequest *(NSURL *URL)
//     {
//         RKPathMatcher *pathMatcher = [RKPathMatcher pathMatcherWithPattern:BASE_URL_SERVER];
//         NSDictionary *filmDict = nil;
//         BOOL match = [pathMatcher matchesPath:BASE_URL_SERVER tokenizeQueryStrings:NO parsedArguments:&filmDict];
//         if (match) {
//             RKResponseDescriptor *currentResponse = nil;
//             if (![RKObjectManager sharedManager].responseDescriptors || [RKObjectManager sharedManager].responseDescriptors.count == 0) {
//                 return nil;
//             }
//             currentResponse = [RKObjectManager sharedManager].responseDescriptors[0];
//             if (!currentResponse || ![currentResponse.mapping isKindOfClass:[RKEntityMapping class]]) {
//                 return nil;
//             }
//             if ([[(RKEntityMapping *)currentResponse.mapping entity].name isEqualToString:NSStringFromClass([Comment class])]) {
//                 return nil;
//             }
//             //             NSLog(@"----gia tri name cua entity = %@---",[(RKEntityMapping *)currentResponse.mapping entity].name);
//             NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//             NSEntityDescription *entity = [NSEntityDescription entityForName:[(RKEntityMapping *)currentResponse.mapping entity].name inManagedObjectContext:[RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext];
//             [fetchRequest setEntity:entity];
//             return fetchRequest;
//         }
//         
//         return nil;
//     }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self setupReskit];
    [[SDWebImageManager sharedManagerWithCachePath:CACHE_IMAGE_PATH] setCacheKeyFilter:^NSString *(NSURL *url) {
        if ([url isKindOfClass:[NSURL class]])
        {
            return [url absoluteString];
        }
        return (NSString *)url;
    }];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
