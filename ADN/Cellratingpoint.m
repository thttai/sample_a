//
//  Cellratingpoint.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "Cellratingpoint.h"

@implementation Cellratingpoint

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
-(void)getratepoint :(NSString *)point : (NSArray *)array
{
    _lbratepoint.text=point;
    DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(-10, 5, 100, 20)];
    rateView.rate = [point intValue];
    rateView.alignment = RateViewAlignmentRight;
    [self.uiviewrating addSubview:rateView];
//rong 118
//dai 12
    
    _lbso1.text= [[array objectAtIndex:0] stringValue];
    _lbso2.text= [[array objectAtIndex:1] stringValue];
    _lbso3.text= [[array objectAtIndex:2] stringValue];
    _lbso4.text= [[array objectAtIndex:3] stringValue];
    _lbso5.text= [[array objectAtIndex:4] stringValue];
    int so1 = [[array objectAtIndex:4] intValue];
    int so2 = [[array objectAtIndex:3] intValue];
    int so3 = [[array objectAtIndex:2] intValue];
    int so4 = [[array objectAtIndex:1] intValue];
    int so5 = [[array objectAtIndex:0] intValue];
    int total = so1+so2+so3+so4+so5;
     _lbtotal.text = [NSString stringWithFormat:@"%d", total];
    if (total ==0)
    {
        _lbcellrate1.frame = CGRectMake(165, 21, 0, 12);
       
       
        _lbcellrate2.frame = CGRectMake(165, 48, 0, 12);
      
        _lbcellrate3.frame = CGRectMake(165, 73, 0, 12);
      
        _lbcellrate4.frame = CGRectMake(165,100,0, 12);
     
       _lbcellrate5.frame = CGRectMake(165, 127, 0, 12);
        return;
    }
    else
    {
      float kqso1 = (float)so1/total;
        int kqlabel = ((kqso1*110));
     _lbcellrate1.frame = CGRectMake(_lbcellrate1.frame.origin.x,_lbcellrate1.frame.origin.y , kqlabel, _lbcellrate1.frame.size.height);
        float kqso2 = (float)so2/total;
        int kqlabel2 = ((kqso2*110));
        _lbcellrate2.frame = CGRectMake(_lbcellrate2.frame.origin.x, _lbcellrate2.frame.origin.y , kqlabel2, _lbcellrate1.frame.size.height);
        float kqso3 = (float)so3/total;
        int kqlabel3 = ((kqso3*110));
        _lbcellrate3.frame = CGRectMake(_lbcellrate3.frame.origin.x, _lbcellrate3.frame.origin.y , kqlabel3, _lbcellrate1.frame.size.height);
       float kqso4 = (float)so4/total;
        int kqlabel4 = ((kqso4*110));
        _lbcellrate4.frame = CGRectMake(_lbcellrate4.frame.origin.x,_lbcellrate4.frame.origin.y , kqlabel4, _lbcellrate1.frame.size.height);
        float kqso5 = (float)so5/total;
        int kqlabel5 = ((kqso5*110));
        _lbcellrate5.frame = CGRectMake(_lbcellrate5.frame.origin.x, _lbcellrate5.frame.origin.y , kqlabel5, _lbcellrate1.frame.size.height);
    }
}
@end
