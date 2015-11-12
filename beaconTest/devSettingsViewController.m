//
//  devSettingsViewController.m
//  beaconTest
//
//  Created by deag on 12/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import "devSettingsViewController.h"

@interface devSettingsViewController ()

@end

@implementation devSettingsViewController
@synthesize firstBeacon, secondBeacon, thirdBeacon;
@synthesize firstBeaconString, secondBeaconString, thirdBeaconString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //check for previously defined values for the beaconStrings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *firstPreviousString = [defaults stringForKey:@"firstBeaconMajor"];
        NSString *secondPreviousString = [defaults stringForKey:@"secondBeaconMajor"];
        NSString *thirdPreviousString = [defaults stringForKey:@"thirdBeaconMajor"];
    if (firstPreviousString) { firstBeacon.text = firstPreviousString;}
    else firstBeacon.text = @"53111";
    if (secondPreviousString) { secondBeacon.text = secondPreviousString; }
    else secondBeacon.text = @"47967";
    if (thirdPreviousString) { thirdBeacon.text = thirdPreviousString; }
    else thirdBeacon.text = @"65397";

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstNewString = firstBeacon.text;
    NSString *secondNewString = secondBeacon.text;
    NSString *thirdNewString = thirdBeacon.text;
    
    
    if (firstNewString) {
        [defaults setObject:firstNewString forKey:@"firstBeaconMajor"];
    }
    if (secondNewString) {
        [defaults setObject:secondNewString forKey:@"secondBeaconMajor"];
    }
    if (thirdNewString) {
        [defaults setObject:thirdNewString forKey:@"thirdBeaconMajor"];
        NSLog(@"a complete induction");
    }
    [defaults synchronize];

}

-(IBAction)clearOut {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    firstBeacon.text = @"53111";
    secondBeacon.text = @"47967";
    thirdBeacon.text = @"65397";
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
