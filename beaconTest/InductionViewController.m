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
@synthesize firstTaskCheck, firstTaskLabel, firstTaskDistance, firstNextButton, firstMajor, resus;
@synthesize secondTaskCheck, secondTaskLabel, secondTaskDistance, secondNextButton, secondMajor, doctorsRoom;
@synthesize thirdTaskCheck, thirdTaskLabel, thirdMajor;
@synthesize beaconManager, beaconRegion, placesByBeacons;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //hide the second and third labels and images
    firstNextButton.hidden =true;
    
    secondTaskLabel.hidden =TRUE;
    secondTaskCheck.hidden =true;
    secondNextButton.hidden =true;
//    NSLog(@"hidden the secondNextButton from view did load");
    secondTaskDistance.hidden =true;
    
    thirdTaskLabel.hidden =true;
    thirdTaskCheck.hidden =FALSE;
    thirdTaskCheck.image = [UIImage imageNamed:@"white_eco_icon.png"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstPreviousString = [defaults stringForKey:@"firstBeaconMajor"];
    NSString *secondPreviousString = [defaults stringForKey:@"secondBeaconMajor"];
    NSString *thirdPreviousString = [defaults stringForKey:@"thirdBeaconMajor"];

    if (firstPreviousString) firstMajor = firstPreviousString;
    if (secondPreviousString) secondMajor = secondPreviousString;
    if (thirdPreviousString) thirdMajor = thirdPreviousString;;

    
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
    
    /*
    //rotate the image
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/ 500.0;
    transform = CATransform3DRotate(transform, 90.0 * M_PI_2, 1, 0, 0);
    self.thirdTaskCheck.layer.transform = transform;
     */
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    
    //see if the test has been done before
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *induced = [defaults stringForKey:@"InductionResult"];
    self.resus = [defaults stringForKey:@"ResusResult"];
    self.doctorsRoom = [defaults stringForKey:@"DoctorsResult"];
/*
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.duration = 3.0;
    animation.repeatCount = HUGE_VALF;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.thirdTaskCheck.layer addAnimation:animation forKey:@"transform.rotation.z"];
*/
    //populate the first image and label
    if (!resus) {
    self.firstTaskLabel.text = @"Please find the resusitation trolley";
    self.firstTaskCheck.image = [UIImage imageNamed:@"Crash_cart.jpg"];
    self.firstTaskDistance.text = @"locating...";
    }
    else if ([resus isEqualToString:@"yes"]) {
        //if Resus test complete, give some feedback
        self.firstTaskLabel.text = @"You've found the resusitation trolley";
        self.firstTaskCheck.image = [UIImage imageNamed:@"Crash_Cart.jpg"];
        self.firstTaskDistance.text = @"Complete";
        self.secondTaskCheck.hidden = FALSE;
        
    }
    if ([resus isEqualToString:@"yes"] && !doctorsRoom) {
        //if Resus complete, but Doctors Room outstanding, show task
        self.secondTaskDistance.hidden = FALSE;
        self.secondTaskLabel.hidden = FALSE;
        self.secondTaskCheck.hidden = FALSE;
        
        self.secondTaskLabel.text = @"Please find the Doctors Office";
        self.secondTaskCheck.image = [UIImage imageNamed:@"doctorRoom1.jpg"];
        self.secondTaskDistance.text = @"locating...";
    }
    if ([doctorsRoom isEqualToString: @"yes"]) {
        //if Doctors Room complete, give some feedback
        self.secondTaskDistance.hidden = FALSE;
        self.secondTaskLabel.hidden = FALSE;
        self.secondTaskCheck.hidden = FALSE;
        NSLog(@"doctors is equal to yes");
        self.secondTaskLabel.text = @"You found the Doctors Office";
        self.secondTaskCheck.image = [UIImage imageNamed:@"doctorRoom1.jpg"];
        self.secondTaskDistance.text = @"Complete";
    }
    if (induced) {
        self.firstNextButton.hidden = TRUE;
        self.secondNextButton.hidden =TRUE;
        NSLog(@"hidden the secondNextButton from view will appear");
        self.thirdTaskLabel.text = @"You have been induced!";
        self.thirdTaskCheck.image = [UIImage imageNamed:@"Yes@3x copy.png"];
        self.thirdTaskLabel.hidden = false;
        self.thirdTaskCheck.hidden = false;
//        [self.thirdTaskCheck.layer removeAllAnimations];
    }
    
}

-(void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
//    [self.thirdTaskCheck.layer removeAllAnimations];
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
    
    if (nearestBeacon.major.intValue == firstMajor.intValue) {
        if (nearestBeacon.proximity >= CLProximityFar) {
            //NSLog(@"nearestBeacon.major invalue == 53111");
            self.firstTaskDistance.text = [NSString stringWithFormat:@"Distance %0.2f m", nearestBeacon.accuracy];
            firstNextButton.hidden = TRUE;
        }
        else if (nearestBeacon.proximity == CLProximityNear) {
            if (!resus) {
                self.firstTaskDistance.text = @"Located";
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                AudioServicesPlaySystemSound(1007);
                self.firstTaskCheck.image = [UIImage imageNamed:@"Yes@3x copy.png"];
                //do something to suggest the feature is there
                firstNextButton.hidden=FALSE;
            }
        }

    }/*
    if (nearestBeacon.major.intValue == 53111) {
        if (nearestBeacon.proximity >= CLProximityFar) {
        //NSLog(@"nearestBeacon.major invalue == 53111");
            self.firstTaskDistance.text = [NSString stringWithFormat:@"Distance %0.2f m", nearestBeacon.accuracy];
            firstNextButton.hidden = TRUE;
        }
        else if (nearestBeacon.proximity == CLProximityNear) {
            if (!resus) {
            self.firstTaskDistance.text = @"Located";
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            AudioServicesPlaySystemSound(1007);
                self.firstTaskCheck.image = [UIImage imageNamed:@"Yes@3x copy.png"];
            //do something to suggest the feature is there
            firstNextButton.hidden=FALSE;
            }
        }
    }*/
    if (nearestBeacon.major.intValue == secondMajor.intValue) {
        if (nearestBeacon.proximity >= CLProximityFar) {
            //NSLog(@"nearestBeacon.major invalue == 53111");
            self.secondTaskDistance.text = [NSString stringWithFormat:@"Distance %0.2f m", nearestBeacon.accuracy];
            secondNextButton.hidden = TRUE;
        }
        else if (nearestBeacon.proximity == CLProximityNear) {
            if (!doctorsRoom) {
                if (resus) {
                    self.secondTaskDistance.text = @"Located";
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    AudioServicesPlaySystemSound(1008);
                    //do something to suggest the feature is there
                    secondTaskCheck.image = [UIImage imageNamed:@"Yes@3x copy.png"];
                    secondNextButton.hidden=FALSE;
                }
            }
    }
    }
    /*
        if (nearestBeacon.major.intValue == 47967) {
            if (nearestBeacon.proximity >= CLProximityFar) {
                //NSLog(@"nearestBeacon.major invalue == 53111");
                self.secondTaskDistance.text = [NSString stringWithFormat:@"Distance %0.2f m", nearestBeacon.accuracy];
                secondNextButton.hidden=TRUE;
                
            }
            else if (nearestBeacon.proximity == CLProximityNear) {
                if (!doctorsRoom) {
                    if (resus) {
                self.secondTaskDistance.text = @"Located";
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                AudioServicesPlaySystemSound(1008);
                //do something to suggest the feature is there
                        secondTaskCheck.image = [UIImage imageNamed:@"Yes@3x copy.png"];
                secondNextButton.hidden=FALSE;
                        }
            }
            }
    }*/
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
        first.navigationItem.title = @"Resusitation Trolley";
        first.navigationItem.backBarButtonItem.title = @"Back";
        first.induction = TRUE;
        first.resus = TRUE;
//        first.doctors = FALSE;
        [[segue destinationViewController] setFeatureSubject:@"resus"];
//        first.featureTExt.text = @"Healthcare organisations have an obligation to provide a high-quality resuscitation service, and to ensure that staff are trained and updated regularly to a level of proficiency appropriate to each individual’s expected role. As part of the quality standards for cardiopulmonary resuscitation practice and training this document provides lists of the minimum equipment and drugs required for cardiopulmonary resuscitation";
    }
       else if (sender == secondNextButton) {
     HotspotViewController *doctor  = [segue destinationViewController];
     //        hot.testLength = 10;
     doctor.navigationItem.title = @"Doctors Office";
           doctor.navigationItem.backBarButtonItem.title = @"Back";

           doctor.featureImage.image = [UIImage imageNamed:@"doctorRoom1.jpg"];
           doctor.induction = TRUE;
           doctor.resus = FALSE;
           doctor.doctors = TRUE;
           doctor.featureTExt.text = @"This is a dedicated place for doctors to escape the nurses and log on to a computer with extremely poor wi fi before being pestered to do a discharge summary for a patient who isn’t going home for a week.";
     
     }
     /*
     else if (sender == aDifferentButton) {
     MapViewController *map = [segue destinationViewController];
     //        map.testLength = 35;
     map.navigationItem.title = @"Chest/Abdomen";
     
     }
     */
}


@end
