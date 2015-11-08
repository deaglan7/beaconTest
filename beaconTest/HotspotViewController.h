//
//  HotspotViewController.h
//  beaconTest
//
//  Created by deag on 08/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotspotViewController : UIViewController {
    
    //induction?
    BOOL induction;
    UIView *testView;
    UILabel *testLabel;
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    
    NSString *testString;

    //test type
    BOOL resus;
    BOOL doctors;
    
    //test result
    BOOL resusYes;
    BOOL doctorsYes;
    
    
    
}
@property (nonatomic) BOOL induction;
@property (nonatomic, retain) IBOutlet UIView *testView;
@property (nonatomic, retain) IBOutlet UILabel *testLabel;
@property (nonatomic, retain) IBOutlet UIButton *button1;
@property (nonatomic, retain) IBOutlet UIButton *button2;
@property (nonatomic, retain) IBOutlet UIButton *button3;
@property (nonatomic, retain) NSString *testString;
@property (nonatomic) BOOL resus;
@property (nonatomic) BOOL doctors;
@property (nonatomic) BOOL resusYes;
@property (nonatomic) BOOL doctorsYes;

-(IBAction) buttonPressed:(id)sender;
-(void)hideQ;

@end
