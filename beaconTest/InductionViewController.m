//
//  InductionViewController.m
//  beaconTest
//
//  Created by deag on 08/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import "InductionViewController.h"

@interface InductionViewController ()

@end

@implementation InductionViewController
@synthesize firstTaskCheck, firstTaskLabel, firstTaskDistance, firstNextButton;
@synthesize secondTaskCheck, secondTaskLabel, secondTaskDistance;
@synthesize thirdTaskCheck, thirdTaskLabel;
@synthesize beaconManager, beaconRegion, placesByBeacons;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //hide the second and third labels and images
    firstNextButton.hidden = TRUE;
    secondTaskLabel.hidden = TRUE;
    secondTaskCheck.hidden = TRUE;
    thirdTaskLabel.hidden = TRUE;
    thirdTaskCheck.hidden = TRUE;
    
    //populate the first image and label
    self.firstTaskLabel.text = @"Please find the Resus Trolley";
    self.firstTaskCheck.image = [UIImage imageNamed:@"Jane.png"];
    self.firstTaskDistance.text = @"locating...";
    
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

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    
    if (nearestBeacon.major.intValue == 53111) {
        if (nearestBeacon.proximity >= CLProximityFar) {
        //NSLog(@"nearestBeacon.major invalue == 53111");
            self.firstTaskDistance.text = [NSString stringWithFormat:@"Distance %0.2f m", nearestBeacon.accuracy];}
        else if (nearestBeacon.proximity == CLProximityNear) {
            self.firstTaskDistance.text = @"Located";
            
            //do something to suggest the feature is there
            firstNextButton.hidden=FALSE;
            
        }
    }
    else if (nearestBeacon.proximity >= CLProximityFar) {
//        self.wardLabel.text = @"Somewhere else";
    }
    else if (nearestBeacon.proximity == CLProximityUnknown) {
//        self.wardLabel.text = @"Proximity Unknown";
    }
    if(nearestBeacon.proximity == CLProximityNear) {
        NSArray *places = [self placesNearBeacon:nearestBeacon];
        //Update the UI here
//        self.statusLabel.text = [places objectAtIndex:0];
//        NSLog(@"%@", places); //remove after implementing UI
    }
    else if (nearestBeacon.proximity >= CLProximityNear) {
//        self.statusLabel.text = @"scanning...";
    }
    
}
#pragma mark handle navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
    if (sender == firstNextButton) {
        HotspotViewController *first = [segue destinationViewController];
        //        induction.testLength = 5;
        first.navigationItem.title = @"Resus";
        first.induction = TRUE;
        first.resus = TRUE;
        first.doctors = FALSE;
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
