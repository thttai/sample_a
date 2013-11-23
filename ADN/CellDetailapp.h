//
//  CellDetailapp.h
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADNDetailViewController.h"
#import "DYRateView.h"
@interface CellDetailapp : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UIButton *btprice;
@property (weak, nonatomic) IBOutlet UIView *uiviewrate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentdetail;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewicon;
@property (strong, nonatomic) Apprecord *apprecorddetail;
-(void)getdetailcontent;
@end
