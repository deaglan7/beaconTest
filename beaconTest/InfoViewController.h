//
//  InfoViewController.h
//  beaconTest
//
//  Created by deag on 08/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
{
    UIButton *femaleToilet;
    UIButton *maleToilet;
    UIButton *admin;
    UIButton *equipment;
    UIButton *emergancy;
    UIButton *search;
}
@property (nonatomic, retain) IBOutlet UIButton *femaleToilet;
@property (nonatomic, retain) IBOutlet UIButton *maleToilet;
@property (nonatomic, retain) IBOutlet UIButton *admin;
@property (nonatomic, retain) IBOutlet UIButton *equipment;
@property (nonatomic, retain) IBOutlet UIButton *emergancy;
@property (nonatomic, retain) IBOutlet UIButton *search;


@end
