//
//  CustomCell.m
//  RapidReportingTool
//
//  Created by Deaglán Ó Meachair on 13/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize givenLabel;
@synthesize modelLabel;
@synthesize questionNum;
//@synthesize given;
//@synthesize model;
@synthesize tick;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Custom initialization
    }
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    //Configure the view for the selected state
}


- (void) dealloc {
//    [givenLabel release];
//    [modelLabel release];
//    [questionNum release];
//    [given release];
//    [model release];
//    [tick release];
//    [super dealloc];
}


@end
