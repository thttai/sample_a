//
//  Celllistapp.h
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/19/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
@interface Celllistapp : UITableViewCell
@property (weak, nonatomic) IBOutlet SDImageView *imageviewlistapp;
@property (weak, nonatomic) IBOutlet UIButton *btPrice;
@property (weak, nonatomic) IBOutlet UILabel *Number;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *Rate;
@property (weak, nonatomic) IBOutlet UILabel *categoryapp;
@property (strong, nonatomic) Apprecord *apprecord;
@property (weak, nonatomic) IBOutlet UILabel *downloadNumLbl;

@property (strong, nonatomic) DYRateView *rateView;

-(void)CustomCell: (NSString *) number;

@end
