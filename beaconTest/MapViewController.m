//
//  MapViewController.m
//  beaconTest
//
//  Created by deag on 08/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize currentLabel, h1Button, h2Button, h3Button;
@synthesize beaconManager, beaconRegion;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.currentLabel.text = @"hello world";
    [self resetButtons];
    
    //Setup polling
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

-(void)beaconManager:(id)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *nearestBeacon = beacons.firstObject;
 
    UIColor *onColor = [UIColor greenColor];
    UIColor *offColor = [UIColor redColor];
    
    [self resetButtons];
    
    //Diabled all buttons
    if (nearestBeacon.major.intValue == 53111) {
        self.currentLabel.text = @"Resuscitation Trolley";
        self.h1Button.backgroundColor = onColor;
    }
    if (nearestBeacon.major.intValue == 65397) {
        self.currentLabel.text = @"Doctor's Office";
        self.h2Button.backgroundColor = onColor;
    }
    if (nearestBeacon.major.intValue == 47967) {
        self.currentLabel.text = @"Toilet";
        self.h3Button.backgroundColor = onColor;
    }
    
        //if (nearestBeacon.proximity >= CLProximityFar) {
            //NSLog(@"nearestBeacon.major invalue == 53111");
        //    self.firstTaskDistance.text = [NSString stringWithFormat:@"Distance %0.2f m", nearestBeacon.accuracy];}
        //else if (nearestBeacon.proximity == CLProximityNear) {
        //    self.firstTaskDistance.text = @"Located";
            
            //do something to suggest the feature is there
        //    firstNextButton.hidden=FALSE;
            
        //
}

- (void) resetButtons{
    UIColor *onColor = [UIColor greenColor];
    UIColor *offColor = [UIColor redColor];
    
    self.h1Button.backgroundColor = offColor;
    self.h2Button.backgroundColor = offColor;
    self.h3Button.backgroundColor = offColor;
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

@end
