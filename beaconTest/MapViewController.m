//
//  MapViewController.m
//  beaconTest
//
//  Created by deag on 08/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import "MapViewController.h"
#import "beaconTest-Swift.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize currentLabel, meLabel, descLabel, h1Button, h2Button, h3Button;
@synthesize beaconManager, beaconRegion;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.currentLabel.text = @"hello world";
    [self resetButtons];
    
    self.descLabel.text = @"Select a hotspot on the map!";
    
    CGRect frame = self.meLabel.frame;
    frame.origin.x = 100;
    frame.origin.y = 100;
    //self.meLabel.frame = frame;
    
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
    
    self.descLabel.text = @"Select a hotspot on map!";
    
    //Diabled all buttons
    if (nearestBeacon.major.intValue == 53111) {
        self.currentLabel.text = @"Resuscitation Trolley";
        self.h1Button.backgroundColor = onColor;
    }
    if (nearestBeacon.major.intValue == 65397) {
        self.currentLabel.text = @"Toilet";
        self.h2Button.backgroundColor = onColor;
    }
    if (nearestBeacon.major.intValue == 47967) {
        self.currentLabel.text = @"Doctor's Office";
        self.h3Button.backgroundColor = onColor;
    }
    
    //Map range 0-50
    
    //Get location of all beacons
    
    
    //Get proximity to all beacons
    
    //Calculate location of user
    
    //Display on map
    
    
    //NSMutableArray *myArray = [NSMutableArray array];
    
    /*
    for(CLBeacon *beacon in beacons) {
        [myArray addObject:[NSString beacon.major()]];
    }
    */
    
    //[NSArray(NSArray(*NSString))] data;}
    
    
    //LocationService *locService = [[LocationService alloc] init];
    //NSString *temp = [locService calculateLocation];
    
    //self.currentLabel.text = temp;
    
    
    
    
    
        //if (nearestBeacon.proximity >= CLProximityFar) {
            //NSLog(@"nearestBeacon.major invalue == 53111");
        //    self.firstTaskDistance.text = [NSString stringWithFormat:@"Distance %0.2f m", nearestBeacon.accuracy];}
        //else if (nearestBeacon.proximity == CLProximityNear) {
        //    self.firstTaskDistance.text = @"Located";
            
            //do something to suggest the feature is there
        //    firstNextButton.hidden=FALSE;
            
        //
}

- (IBAction) hotspotClicked:(id)sender {
    //Start the questions
    self.descLabel.text = @"No description is available";
    
    if(sender == h1Button)
    {
        self.currentLabel.text = @"Resuscitation Trolley";
        self.descLabel.text = @"The resuscitation trolley is kept here.";
    }
    
    if(sender == h2Button)
    {
        self.currentLabel.text = @"Toilet";
        self.descLabel.text = @"The code for the toilet is 1234.";
    }
    
    if(sender == h3Button)
    {
                self.currentLabel.text = @"Doctor's Office";
        self.descLabel.text = @"The doctors rooms is near the entrance.";
    }
    
    /*
     if (resus) {
        //do something to react to the button presses
        if (sender == button2) {
            //congrats
            self.testLabel.text = @"Well Done";
            resusYes = TRUE;
            self.navigationItem.hidesBackButton = NO;
        }
        else {
            //hard luck
            testLabel.text = @"Sorry, try again";
            [self performSelector:@selector(hideQ) withObject:testLabel afterDelay:2.0];
            resusYes = FALSE;
        }
    }
    if (doctors) {
        if (sender == button1) {
            //congrats
            self.testLabel.text = @"Well Done";
            doctorsYes = TRUE;
            self.navigationItem.hidesBackButton = NO;
        }
        else {
            //hard luck
            testLabel.text = @"Sorry, try again";
            [self performSelector:@selector(hideQ) withObject:testLabel afterDelay:2.0];
            doctorsYes = FALSE;
        }
    }
    
    //store the result
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (resusYes) {
        [defaults setObject:@"yes" forKey:@"ResusResult"];
    }
    else if (doctorsYes) {
        [defaults setObject:@"yes" forKey:@"DoctorsResult"];
    }
    if (resusYes && doctorsYes) {
        [defaults setObject:@"yes" forKey:@"InductionResult"];
    }
     */
    //s[defaults synchronize];
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
