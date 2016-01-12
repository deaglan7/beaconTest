//
//  ListViewController.m
//  beaconTest
//
//  Created by deag on 02/12/2015.
//  Copyright © 2015 Anu Technologies. All rights reserved.
//
#import "CustomCell.h"
#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark Downloads
//globalConfig *obj = [globalConfig getConfig];
-(void)checkDownloads {
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
NSString *downloadDir =[paths objectAtIndex:0];
downloadDir = [downloadDir stringByAppendingPathComponent:@"Downloads"];

NSFileManager *fm = [NSFileManager defaultManager];
NSArray *downloadArray = [fm contentsOfDirectoryAtPath:downloadDir error:nil];
//   NSArray *downloadArray = [fm contentsOfDirectoryAtPath:obj.downloadPath error:nil];
if (downloadArray) {
    //        NSLog(@"looking for downloads");
    //    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.plist'"];
    NSPredicate *fltr2 = [NSPredicate predicateWithFormat:@"self BEGINSWITH 'err_lb_inapp'"];
    //    NSPredicate *fltr2 = [NSPredicate predicateWithFormat:@"self BEGINSWITH 'imagebank'"];
    //    NSArray *onlyPlists = [downloadArray filteredArrayUsingPredicate:fltr];
    NSArray *onlyImagebanks = [downloadArray filteredArrayUsingPredicate:fltr2];
    //    NSLog(@"found %lu files in cacheDir", (unsigned long)[downloadArray count]);
    //    NSLog(@"found %lu plists", (unsigned long)[onlyPlists count]);
    //    NSLog(@"found %lu imagebank plists", (unsigned long)[onlyImagebanks count] );
    
    int purchasedArr = (int)[onlyImagebanks count];
    for (int i=0; i<purchasedArr; i++) {
        NSObject *object = [onlyImagebanks objectAtIndex:i];
        //NSObject *object = [onlyImagebanks objectAtIndex:0];
        //    NSObject *object = [onlyPlists objectAtIndex:0];
        NSString *plistStr = (object.description);
        plistStr = [downloadDir stringByAppendingPathComponent:plistStr];
        NSMutableArray *arrayM3 = [[NSMutableArray alloc] initWithContentsOfFile:plistStr];

        }
    }
}
#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    self.score = [scoreCard count];
//    return [self.scoreCard count];
    return [roomFeatures count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[CustomCell class]])
                cell = (CustomCell *)oneObject;
    }
    /*
    NSUInteger row = [indexPath row];
    if ([scoreCard objectAtIndex:row] != [NSNull null]) {
        UIColor *bottomColour = [UIColor colorWithRed:0.21176 green:0.66274 blue:0.87843 alpha:1.0];
        
        NSDictionary *rowData = [scoreCard objectAtIndex:row];
        //        cell.modelLabel.text = [rowData objectForKey:@"model"];
        //        cell.givenLabel.text = [rowData objectForKey:@"answer"];
        cell.questionNum.text =  [NSString stringWithFormat:@"%lu", (unsigned long) row+1];
        
        NSString *modelA = [rowData objectForKey:@"model"];
        NSString *answerA = [rowData objectForKey:@"answer"];
        //        NSLog(answerA);
        if ([answerA isEqualToString:@"Normal"]) {
            //set the border around the normal (modelLabel) object
            cell.modelLabel.font = [UIFont boldSystemFontOfSize:18];
            [[cell.modelLabel layer] setBorderWidth:4.0f];
            [[cell.modelLabel layer] setCornerRadius:8.0f];
            [[cell.modelLabel layer] setBorderColor:bottomColour.CGColor];
        } else if ([answerA isEqualToString:@"Abnormal"])
        {
            cell.givenLabel.font = [UIFont boldSystemFontOfSize:18];
            [[cell.givenLabel layer] setBorderWidth:4.0f];
            [[cell.givenLabel layer] setCornerRadius:8.0f];
            [[cell.givenLabel layer] setBorderColor:bottomColour.CGColor];
        }
        
        if (modelA.length != answerA.length) {
            
            cell.tick.image = [UIImage imageNamed:@"incorrect.png"];
            score--;
        }
    }
    
    if ([scoreCard objectAtIndex:row] == [NSNull null]) {
        //        cell.modelLabel.text = @"not answered";
        //        cell.givenLabel.text = @"not answered";
        cell.questionNum.text = [NSString stringWithFormat:@"%lu", (unsigned long) row+1];
        cell.tick.image = [UIImage imageNamed:@"incorrect.png"];
        
    }
    
    if (testTime == 5) {
        //        cell.given.textColor = [UIColor colorWithRed:0.6 green:0.25 blue:0.2 alpha:1.0];
        //        cell.model.textColor= [UIColor colorWithRed:0.6 green:0.25 blue:0.2 alpha:1.0];
    }
    else if (testTime == 10) {
        //        cell.given.textColor = [UIColor colorWithRed:0.8 green:0.65 blue:0.17 alpha:1.0];
        //       cell.model.textColor= [UIColor colorWithRed:0.8 green:0.65 blue:0.17 alpha:1.0];
    }
    else if (testTime == 35) {
        //        cell.given.textColor = [UIColor colorWithRed:0.12 green:0.5 blue:0.6 alpha:1.0];
        //        cell.model.textColor= [UIColor colorWithRed:0.12 green:0.5 blue:0.6 alpha:1.0];
    }
    */
    //disable the blue highlighting
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //for iOS7, the cell background color must be set
    //    cell.backgroundColor = [UIColor colorWithRed:0.09 green:0.12 blue:0.14 alpha:1.0];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}



@end
