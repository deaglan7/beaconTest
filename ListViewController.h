//
//  ListViewController.h
//  beaconTest
//
//  Created by deag on 02/12/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EstimoteSDK/EstimoteSDK.h>
#import "HotspotViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ListViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, ESTBeaconManagerDelegate>
{
    UITableView *roomFeaturesTable;
    NSArray *roomFeatures;
    
    NSString *firstMajor;
    NSString *resus;
    
    NSString *secondMajor;
    NSString *doctorsRoom;
    
    NSString *thirdString;
    
    ESTBeaconManager *beaconManager;
    CLBeaconRegion *region;
}

@property (nonatomic, retain) IBOutlet UITableView *roomFeaturesTable;
@property (nonatomic, retain) NSArray *roomFeatures;

@property (nonatomic, retain) NSString *firstMajor;
@property (nonatomic, retain) NSString *resus;

@property (nonatomic, retain) NSString *secondMajor;
@property (nonatomic, retain) NSString *doctorsRoom;

@property (nonatomic, retain) NSString *thirdMajor;

@property (nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic) CLBeaconRegion *beaconRegion;
@property (nonatomic) NSDictionary *placesByBeacons;



@end
