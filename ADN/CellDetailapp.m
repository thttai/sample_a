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

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.rateView = [[DYRateView alloc] initWithFrame:CGRectMake(111, 80, 10.0f*7, 10.0f)];
        self.rateView.alignment = RateViewAlignmentLeft;
        self.rateView.starSize = 9.0f;
        [self.contentView addSubview:self.rateView];
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
    self.lbdev.text=_apprecorddetail.dev_n;
    self.lbtitle.text =_apprecorddetail.name;
    [self.btprice setTitle:@"Free" forState:UIControlStateNormal];
    _btprice.layer.borderWidth=1;
    _btprice.layer.borderColor =  [(_btprice.titleLabel.textColor) CGColor];
    
    _btprice.layer.cornerRadius = 4;
    //Add image to list app to list app
    [self.imageviewicon setImageWithURL:[NSURL URLWithString:_apprecorddetail.icon]];
    _imageviewicon.clipsToBounds = YES;
    _imageviewicon.layer.cornerRadius = 15;
    self.rateView.rate = [_apprecorddetail.rate intValue];
    self.downloadNumLbl.text = [NSString stringWithFormat:@"(%@)", _apprecorddetail.downloads];
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    UIImage *placeholder = [UIImage imageNamed:@"placeholder.png"];
    _imageviewicon.clipsToBounds = YES;
    _imageviewicon.layer.cornerRadius = 15;
    [_imageviewicon setImage:placeholder];
}

-(IBAction)handleUpdateVersion:(id)sender
{
    // get indexpath button
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_apprecorddetail.official_link]];
}
@end
