//
//  devSettingsViewController.h
//  beaconTest
//
//  Created by deag on 12/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface devSettingsViewController : UIViewController {
    UITextField *firstBeacon;
    NSString *firstBeaconString;
    UITextField *secondBeacon;
    NSString *secondBeaconString;
    UITextField *thirdBeacon;
    NSString *thirdBeaconString;
    UIButton *clearHistory;
}
@property (nonatomic, retain) IBOutlet UITextField *firstBeacon;
@property (nonatomic, retain) NSString *firstBeaconString;
@property (nonatomic, retain) IBOutlet UITextField *secondBeacon;
@property (nonatomic, retain) NSString *secondBeaconString;
@property (nonatomic, retain) IBOutlet UITextField *thirdBeacon;
@property (nonatomic, retain) NSString *thirdBeaconString;
@property (nonatomic, retain) IBOutlet UIButton *clearHistory;

-(IBAction)clearOut;
-(IBAction)checkString:(UITextField *)str;
@end
