//
//  AppDelegate.h
//  beaconTest
//
//  Created by deag on 07/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <EstimoteSDK/EstimoteSDK.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    CLBeaconRegion *resusRegion;
    CLBeaconRegion *toilet;
    CLBeaconRegion *doctorsRoom;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) CLBeaconRegion *resusRegion;
@property (strong, nonatomic) CLBeaconRegion *toilet;
@property (strong, nonatomic) CLBeaconRegion *doctorsRoom;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

