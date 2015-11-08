//
//  InductionViewController.h
//  beaconTest
//
//  Created by deag on 08/11/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InductionViewController : UIViewController
{
    UIImageView *firstTaskCheck;
    UILabel *firstTaskLabel;
    UILabel *firstTaskDistance;
    UIImageView *secondTaskCheck;
       UILabel *secondTaskLabel;
    UILabel *secondTaskDistance;
    UIImageView *thirdTaskCheck;
       UILabel *thirdTaskLabel;
    
}

@property (nonatomic, retain) IBOutlet UIImageView *firstTaskCheck;
@property (nonatomic, retain) IBOutlet UILabel *firstTaskLabel;
@property (nonatomic, retain) IBOutlet UILabel *firstTaskDistance;
@property (nonatomic, retain) IBOutlet UIImageView *secondTaskCheck;
@property (nonatomic, retain) IBOutlet UILabel *secondTaskLabel;
@property (nonatomic, retain) IBOutlet UILabel *secondTaskDistance;

@property (nonatomic, retain) IBOutlet UIImageView *thirdTaskCheck;
@property (nonatomic, retain) IBOutlet UILabel *thirdTaskLabel;

@end
