//
//  CustomCell.h
//  RapidReportingTool
//
//  Created by Deaglán Ó Meachair on 13/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell {
    UILabel *givenLabel;
    UILabel *modelLabel;
    UILabel *questionNum;
//    UILabel *given;
//    UILabel *model;
    UIImageView *tick;
}
@property (nonatomic, retain) IBOutlet UILabel *givenLabel;
@property (nonatomic, retain) IBOutlet UILabel *modelLabel;
@property (nonatomic, retain) IBOutlet UILabel *questionNum;
//@property (nonatomic, retain) IBOutlet UILabel *given;
//@property (nonatomic, retain) IBOutlet UILabel *model;
@property (nonatomic, retain) IBOutlet UIImageView *tick;

@end
