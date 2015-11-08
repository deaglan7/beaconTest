//
//  ViewController.m
//  beaconTest
//
//  Created by deag on 07/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import "ViewController.h"
#import "InductionViewController.h"
#import "HotspotViewController.h"
#import "MapViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "beaconTest-Swift.h"


@interface ViewController () <ESTBeaconManagerDelegate>

@property (nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic) CLBeaconRegion *beaconRegion;
@property (nonatomic) NSDictionary *placesByBeacons;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;
@property (nonatomic, retain) IBOutlet UILabel *wardLabel;
//@property (nonatomic) LocationService *locationService;
@end

@implementation ViewController
@synthesize induce;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LocationService *locService = [[LocationService alloc] init];
    NSString *temp = [locService getLocation];
    //self.wardLabel.text = temp;
    
    //self.locationService = [LocationService new];
    //[self.locationService getLocation];
    
    //set a list of places by beacons
    self.placesByBeacons = @{@"53111:27862": @{@"Resus": @1, //read as: it's 50 meters from "Heavenly Sandwiches" to beacon with major 6754 adn minor 54361
                                              @"Toilet": @5,
                                              @"Doctors Room":@10
                                              },
                             @"65397:35579" : @{
                                     @"Resus":@10,
                                     @"Toilet":@1,
                                     @"Doctors Room":@5},
                             @"47967:54846": @{
                                     @"Resus":@5,
                                     @"Toilet":@10,
                                     @"Doctors Room":@1
                                     }
                             
                             };
    
    
    //define and start a beaconManager
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"] identifier:@"ranged region"];
    [self.beaconManager requestAlwaysAuthorization];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
}

- (NSArray *)placesNearBeacon:(CLBeacon *)beacon  {
    NSString *beaconKey = [NSString stringWithFormat: @"%@:%@",
                           beacon.major, beacon.minor];
    NSDictionary *places = [self.placesByBeacons objectForKey:beaconKey];
    NSArray *sortedPlaces = [places keysSortedByValueUsingComparator: ^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2];
    }
                             ];
    return sortedPlaces;
}


-(void)beaconManager:(id)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *nearestBeacon = beacons.firstObject;
    
    if (nearestBeacon.proximity <= CLProximityFar) {
        self.wardLabel.text = @"Addison Ward";
    }
    else if (nearestBeacon.proximity >= CLProximityFar) {
        self.wardLabel.text = @"Somewhere else";
    }
    else if (nearestBeacon.proximity == CLProximityUnknown) {
        self.wardLabel.text = @"Proximity Unknown";
    }
    if(nearestBeacon.proximity == CLProximityNear) {
        NSArray *places = [self placesNearBeacon:nearestBeacon];
        //Update the UI here
        self.statusLabel.text = [places objectAtIndex:0];
//        NSLog(@"%@", places); //remove after implementing UI
    }
        else if (nearestBeacon.proximity >= CLProximityNear) {
            self.statusLabel.text = @"scanning...";
        }
    
}

#pragma mark handle navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
    if (sender == induce) {
        InductionViewController *induction = [segue destinationViewController];
//        induction.testLength = 5;
        induction.navigationItem.title = @"Induction";
    }
/*    else if (sender == anotherButton) {
        HotspotViewController *hot = [segue destinationViewController];
//        hot.testLength = 10;
        hot.navigationItem.title = @"Upper Body";
        
    }
    else if (sender == aDifferentButton) {
        MapViewController *map = [segue destinationViewController];
//        map.testLength = 35;
        map.navigationItem.title = @"Chest/Abdomen";
 
    }
*/
}

@end
