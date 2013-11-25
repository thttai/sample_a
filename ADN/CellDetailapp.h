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
@property (weak, nonatomic) IBOutlet UIImageView *imageviewicon;
@property (weak, nonatomic) IBOutlet UILabel *downloadNumLbl;
@property (strong, nonatomic) DYRateView *rateView;
@property (strong, nonatomic) Apprecord *apprecorddetail;
@property (strong, nonatomic) IBOutlet UILabel *lbdev;
-(void)getdetailcontent;
@end
