//
//  Cellratingpoint.h
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
#import "ADNDetailViewController.h"
@interface Cellratingpoint : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *uiviewrating;
@property (strong, nonatomic) IBOutlet UILabel *lbratepoint;
@property (strong, nonatomic) IBOutlet UILabel *lbcellrate3;
@property (strong, nonatomic) IBOutlet UILabel *lbcellrate5;
@property (strong, nonatomic) IBOutlet UILabel *lbcellrate4;
@property (strong, nonatomic) IBOutlet UILabel *lbcellrate1;
@property (strong, nonatomic) IBOutlet UILabel *lbcellrate2;
@property (strong, nonatomic) IBOutlet UILabel *lbso1;
@property (strong, nonatomic) IBOutlet UILabel *lbso2;
@property (strong, nonatomic) IBOutlet UILabel *lbso3;
@property (strong, nonatomic) IBOutlet UILabel *lbso4;
@property (strong, nonatomic) IBOutlet UILabel *lbso5;
@property (strong, nonatomic) IBOutlet UILabel *lbtotal;
-(void)getratepoint :(NSString *)point : (NSArray *)array;
@end
