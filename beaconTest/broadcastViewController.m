//
//  broadcastViewController.m
//  beaconTest
//
//  Created by deag on 17/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import "broadcastViewController.h"

@interface broadcastViewController ()

@end

@implementation broadcastViewController
@synthesize broadcastMajor, broadcastButton, broadcastMajorID;
@synthesize myBeaconRegion, myBeaconData, peripheralManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    broadcasting = FALSE;
    // Create a NSUUID object
//    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    
    // Initialize the Beacon Region
//    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:53111
                                                                  //minor:1
                                                           //  identifier:@"com.appcoda.testregion"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)broadcast {
    
    if (!broadcasting) {
    //Get the textfield entry
    NSString *broadcastString = broadcastMajor.text;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterBehaviorDefault;
    u_int16_t broadcastNumber = [[f numberFromString:broadcastString] unsignedShortValue];
//    u_int16_t majorT = (numberFromString:broadcastString);
    // Create a NSUUID object
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];

    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:broadcastNumber identifier:@"com.appcoda.testregion"];
    
    //Set the Beacon Major
    //maybe need to introduce a new beaconRegion, as values seem to be read-only
//    self.myBeaconRegion.major.doubleValue = [broadcastString doubleValue];
    
    // Get the beacon data to advertise
    self.myBeaconData = [self.myBeaconRegion peripheralDataWithMeasuredPower:nil];
    
    // Start the peripheral manager
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
        broadcasting = TRUE;
    }
    else if (broadcasting) {
        // Update our status label
        self.broadcastMajorID.text = @"Stopped";
        self.broadcastButton.titleLabel.text = @"Broadcast";
        
        // Stop broadcasting
        [self.peripheralManager stopAdvertising];
        broadcasting = FALSE;
    }
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        // Bluetooth is on
        
        // Update our status label
        self.broadcastMajorID.text = [NSString stringWithFormat:@"Broadcasting %@", broadcastMajor.text];
        self.broadcastButton.titleLabel.text = @"Stop";
        // Start broadcasting
        [self.peripheralManager startAdvertising:self.myBeaconData];
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOff)
    {
        // Update our status label
        self.broadcastMajorID.text = @"Stopped";
        
        // Bluetooth isn't on. Stop broadcasting
        [self.peripheralManager stopAdvertising];
    }
    else if (peripheral.state == CBPeripheralManagerStateUnsupported)
    {
        self.broadcastMajorID.text = @"Unsupported";
    }
}


- (IBAction)checkString:(UITextField *)str {
    NSUInteger length = [str.text length];
    NSLog(@"string length %lu", (unsigned long)length);
    
    if (length != 5) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Wrong Length" message:@"Please make sure you enter only a five digit value" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            //do something here
            //            [self performSegueWithIdentifier:@"inducer" sender:induce];
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        //        UIAlertAction *cancelMe = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        //            [alert dismissViewControllerAnimated:YES completion:nil];
        //        }];
        [alert addAction:ok];
        //        [alert addAction:cancelMe];
        [self presentViewController:alert animated:YES completion:nil];
        [str resignFirstResponder];
    }
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
