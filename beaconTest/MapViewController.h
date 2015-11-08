//
//  MapViewController.h
//  beaconTest
//
//  Created by deag on 08/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EstimoteSDK/EstimoteSDK.h>

@interface MapViewController : UIViewController <ESTBeaconManagerDelegate>
{
    UILabel *currentLabel;
    UILabel *meLabel;
    UILabel *descLabel;
    UIButton *h1Button;
    UIButton *h2Button;
    UIButton *h3Button;

ESTBeaconManager *beaconManager;
        CLBeaconRegion *region;
}

@property (nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic) CLBeaconRegion *beaconRegion;

@property (nonatomic, retain) IBOutlet UILabel *currentLabel;
@property (nonatomic, retain) IBOutlet UILabel *meLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic, retain) IBOutlet UIButton *h1Button;
@property (nonatomic, retain) IBOutlet UIButton *h2Button;
@property (nonatomic, retain) IBOutlet UIButton *h3Button;

-(IBAction) hotspotClicked:(id)sender;

@end