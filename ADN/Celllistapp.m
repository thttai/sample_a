//
//  Celllistapp.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/19/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "Celllistapp.h"

@implementation Celllistapp
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {      
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    UIImage *placeholder = [UIImage imageNamed:@"placeholder.png"];
    _imageviewlistapp.layer.cornerRadius=3;
    _imageviewlistapp.clipsToBounds = YES;
    _imageviewlistapp.layer.cornerRadius = 15;
    [_imageviewlistapp setImage:placeholder];
    
}
//customCell listapp
-(void)CustomCell: (NSString *) number 
{
    
    //NSLog("%@",Apprecord.title);
     //Add label Number to list app
    [self.Number setText:number];
    //Add label title
    [self.Title setText:_apprecord.name];
    //Add label category to list app
    [self.categoryapp setText:_apprecord.cat_n];
    //Add Button Price to list app
   // [self.Rate setText:_apprecord.rate];
     [self.btPrice setTitle:@"Free" forState:UIControlStateNormal];
    _btPrice.layer.borderWidth=1;
    _btPrice.layer.borderColor = [UIColor blueColor].CGColor;
    _btPrice.layer.cornerRadius = 4;
    //Add image to list app to list app
    [self.imageviewlistapp setImageWithURL:[NSURL URLWithString:_apprecord.icon]];
    CGRect frameCate = self.categoryapp.frame;
//    DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(frameCate.origin.x, frameCate.origin.y + frameCate.size.height, frameCate.size.width, frameCate.size.height)];
    DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(frameCate.origin.x, frameCate.origin.y + frameCate.size.height, 14.0f*7, 14.0f)];
    rateView.rate = [_apprecord.rate intValue];
    rateView.alignment = RateViewAlignmentLeft;
    rateView.starSize = 9.0f;
    [self.contentView addSubview:rateView];
    self.downloadNumLbl.text = [NSString stringWithFormat:@"(%@)", _apprecord.downloads];
   }
@end
