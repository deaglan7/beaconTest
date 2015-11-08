//
//  HotspotViewController.m
//  beaconTest
//
//  Created by deag on 08/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import "HotspotViewController.h"

@interface HotspotViewController ()

@end

@implementation HotspotViewController
@synthesize induction, testView, testLabel, button1, button2, button3;
@synthesize testString;
@synthesize resus, doctors;
@synthesize featureImage;
@synthesize resusYes, doctorsYes;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    testView.hidden = TRUE;
    resusYes = FALSE;
    doctorsYes = FALSE;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *induced = [defaults stringForKey:@"InductionResult"];
    NSString *alreadyResus = [defaults stringForKey:@"ResusResult"];
    NSString *alreadyDoc = [defaults stringForKey:@"DoctorsResult"];
    if ([alreadyResus isEqualToString:@"yes"]) {
        resusYes = TRUE;
    }
    if ([alreadyDoc isEqualToString:@"yes"]) {
        doctorsYes = TRUE;
    }
    
    
    if (induction) {
        NSLog(@"we are in an induction");
        testView.hidden = FALSE;
        if (resus) {
            testLabel.text = @"where is the LMA?";
        }
        else if (doctors)
        {
            testLabel.text = @"where is the Bleep directory?";
        }
    }
    
    
    
    
    
    
}

-(void) viewDidAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;
    
    //which question
    
}


- (IBAction) buttonPressed:(id)sender {
    //Start the questions
    self.testString = self.testLabel.text;
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
    [defaults synchronize];
}


-(void)hideQ {
    self.testLabel.text = testString;
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
