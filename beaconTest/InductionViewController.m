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
@synthesize firstTaskCheck, firstTaskLabel, firstTaskDistance;
@synthesize secondTaskCheck, secondTaskLabel, secondTaskDistance;
@synthesize thirdTaskCheck, thirdTaskLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //hide the second and third labels and images
    secondTaskLabel.hidden = TRUE;
    secondTaskCheck.hidden = TRUE;
    thirdTaskLabel.hidden = TRUE;
    thirdTaskCheck.hidden = TRUE;
    
    //populate the first image and label
    self.firstTaskLabel.text = @"Please find the Resus Trolley";
    self.firstTaskCheck.image = [UIImage imageNamed:@"resus.jpg"];
    self.firstTaskDistance.text = @"locating...";
    
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
