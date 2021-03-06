//
//  InductionViewController.h
//  beaconTest
//
//  Created by deag on 08/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EstimoteSDK/EstimoteSDK.h>
#import "HotspotViewController.h"
#import <AudioToolbox/AudioToolbox.h>


@interface InductionViewController : UIViewController <ESTBeaconManagerDelegate>
{
    UIImageView *firstTaskCheck;
    UILabel *firstTaskLabel;
    UILabel *firstTaskDistance;
    UIButton *firstNextButton;
    NSString *firstMajor;
    NSString *resus;
    
    UIImageView *secondTaskCheck;
    UILabel *secondTaskLabel;
    UILabel *secondTaskDistance;
    UIButton *secondNextButton;
    NSString *secondMajor;
    NSString *doctorsRoom;
    
    UIImageView *thirdTaskCheck;
    UILabel *thirdTaskLabel;
    NSString *thirdString;
    
    ESTBeaconManager *beaconManager;
    CLBeaconRegion *region;
}

@property (nonatomic, retain) IBOutlet UIImageView *firstTaskCheck;
@property (nonatomic, retain) IBOutlet UILabel *firstTaskLabel;
@property (nonatomic, retain) IBOutlet UILabel *firstTaskDistance;
@property (nonatomic, retain) IBOutlet UIButton *firstNextButton;
@property (nonatomic, retain) NSString *firstMajor;
@property (nonatomic, retain) NSString *resus;

@property (nonatomic, retain) IBOutlet UIImageView *secondTaskCheck;
@property (nonatomic, retain) IBOutlet UILabel *secondTaskLabel;
@property (nonatomic, retain) IBOutlet UILabel *secondTaskDistance;
@property (nonatomic, retain) IBOutlet UIButton *secondNextButton;
@property (nonatomic, retain) NSString *secondMajor;
@property (nonatomic, retain) NSString *doctorsRoom;


@property (nonatomic, retain) IBOutlet UIImageView *thirdTaskCheck;
@property (nonatomic, retain) IBOutlet UILabel *thirdTaskLabel;
@property (nonatomic, retain) NSString *thirdMajor;

@property (nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic) CLBeaconRegion *beaconRegion;
@property (nonatomic) NSDictionary *placesByBeacons;


@end
