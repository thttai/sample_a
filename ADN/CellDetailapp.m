//
//  CellDetailapp.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "CellDetailapp.h"

@implementation CellDetailapp

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)getdetailcontent
{
        self.lbtitle.text =_apprecorddetail.name;
    [self.btprice setTitle:@"Free" forState:UIControlStateNormal];
    //    if ([_apprecord.rate_c isEqualToString:@"0"]){
    //        [self.btPrice setTitle:@"Free" forState:UIControlStateNormal];
    //    }
    //    else
    //    {
    //        [self.btPrice setTitle:_apprecord.rate_c forState:UIControlStateNormal];
    //    }
    _btprice.layer.borderWidth=1;
    _btprice.layer.borderColor = [UIColor blueColor].CGColor;
    _btprice.layer.cornerRadius = 4;
    //Add image to list app to list app
    [self.imageviewicon setImageWithURL:[NSURL URLWithString:_apprecorddetail.icon]];
    DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    rateView.rate = [_apprecorddetail.rate intValue];
    rateView.alignment = RateViewAlignmentRight;
    [self.uiviewrate addSubview:rateView];
}

@end
