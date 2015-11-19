//
//  broadcastViewController.h
//  beaconTest
//
//  Created by deag on 17/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@import Foundation;

#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface broadcastViewController : UIViewController <CBCentralManagerDelegate> {
    UITextField *broadcastMajor;
    UIButton *broadcastButton;
    UILabel *broadcastMajorID;
    BOOL broadcasting;
}
@property (nonatomic, retain) IBOutlet UITextField *broadcastMajor;
@property (nonatomic, retain) IBOutlet UIButton *broadcastButton;
@property (nonatomic, retain) IBOutlet UILabel *broadcastMajorID;
@property (nonatomic) BOOL broadcasting;

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) NSDictionary *myBeaconData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;


- (IBAction)broadcast;
-(IBAction)checkString:(UITextField *)str;

@end
