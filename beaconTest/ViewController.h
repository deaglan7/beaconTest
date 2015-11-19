//
//  ViewController.h
//  beaconTest
//
//  Created by deag on 07/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
//here we are
    UIButton *induce;
    UIButton *info;
    BOOL induceMe;
}
@property (nonatomic, retain) IBOutlet UIButton *induce;
@property (nonatomic, retain) IBOutlet UIButton *info;
@property (nonatomic) BOOL induceMe;
@end

