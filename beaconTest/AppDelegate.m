//
//  AppDelegate.m
//  beaconTest
//
//  Created by deag on 07/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()
// add property to hold the beacon manager
@property (nonatomic) ESTBeaconManager *beaconManager;
@end

@implementation AppDelegate
@synthesize resusRegion, toilet, doctorsRoom;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    [self.beaconManager requestAlwaysAuthorization];
    
 //   resusRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"] major:53111 minor:27862 identifier:@"resusRegion"];
//    if (resusRegion) {
//        NSLog(@"resusRegion created");
//    }
    toilet = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"] major:65397 minor:35579 identifier:@"toilet"];
    doctorsRoom = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"] major:47967 minor:54846 identifier:@"doctorsRoom"];
    
//    [self.beaconManager startMonitoringForRegion:resusRegion];
//    [self.beaconManager startMonitoringForRegion:toilet];
//    [self.beaconManager startMonitoringForRegion:doctorsRoom];
    
    [self.beaconManager startMonitoringForRegion:[[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"] major:53111 minor:27862 identifier:@"monitored region"]];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil]];
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "anu-tech.beaconTest" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"beaconTest" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"beaconTest.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
#pragma mark Beacon Methods
- (void)beaconManager:(id)manager didEnterRegion:(CLBeaconRegion *)region {
/*
    if (region == resusRegion) {
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody =
    @"You're in the Psych ward!!!!. "
    "I'm the Resus machine"
    "I am red, against the wall"
    "Hope we never have to get to know each other any better!";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        NSLog(@"resus region detected");
    }
    if (region == toilet) {
    UILocalNotification *notification = [UILocalNotification new];
            notification.alertBody =
            @"You're in the Psych ward!!!!. "
            "I'm the Toilet  "
            "My entry code is 12321 "
            "I am here to relieve you";
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
    }
    if (region == doctorsRoom) {
    UILocalNotification *notification = [UILocalNotification new];
            notification.alertBody =
            @"You're in the Psych ward!!!!. "
            "This is the Doctor's Room"
            "I'm the big room with windows"
            "If nurses are annoying you, come here";
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];

}
    else {
        
        UILocalNotification *notification = [UILocalNotification new];
        notification.alertBody =
        @"You're in the Psych ward!!!!. "
        "Welcome";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        NSLog(@"resus region detected");
    }
 */
}
/*-(void)beaconManager:(id)manager didDetermineState:(CLRegionState)state forRegion:(CLBeaconRegion *)region
{

    if (region == resusRegion) {
        NSLog(@"I'm in the resusRegion, and haven't left");
    }
}*/
@end
