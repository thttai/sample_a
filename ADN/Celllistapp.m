//
//  Celllistapp.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/19/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "Celllistapp.h"

#define PADDING 3

@implementation Celllistapp
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.rateView = [[DYRateView alloc] initWithFrame:CGRectZero];
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
    
    // Get old Title font size
    CGSize oldTitleSize = [self.Title.text sizeWithFont:self.Title.font constrainedToSize:CGSizeMake(self.Title.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
//    NSLog(@"-OLD----%f--%f",oldTitleSize.width,oldTitleSize.height);

    int numberOldTitleLine = self.rateView.frame.size.width == 0?0:1;
    if (oldTitleSize.height > 17) {
        numberOldTitleLine = 2;
    }
    
    //Add label title
    [self.Title setText:_apprecord.name];
    
    // Get Title size
    CGSize titleSize = [self.Title.text sizeWithFont:self.Title.font constrainedToSize:CGSizeMake(self.Title.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
//    NSLog(@"--New---%f--%f",titleSize.width,titleSize.height);
    
    // Adjust Title, Category, Stars based on Title number of line
    int numberTitleLine = 1;
    if (titleSize.height > 17) {
        numberTitleLine = 2;
    }
    
    if (numberTitleLine == numberOldTitleLine) {
        // Do nothing due to reused cell had the same size with old cell
    } else {
        if (numberTitleLine == 1) {
            self.Title.frame = CGRectMake(self.Title.frame.origin.x, 18, self.Title.frame.size.width, titleSize.height);
        } else {
            self.Title.frame = CGRectMake(self.Title.frame.origin.x, 9, self.Title.frame.size.width, 2*17.0f);
        }
        self.categoryapp.frame = CGRectMake(self.categoryapp.frame.origin.x, self.Title.frame.origin.y + self.Title.frame.size.height + PADDING, self.categoryapp.frame.size.width, 15);
        
    }
    if (numberTitleLine != numberOldTitleLine || self.rateView.frame.size.width == 0)
    {
        self.downloadNumLbl.frame = CGRectMake(self.downloadNumLbl.frame.origin.x, self.categoryapp.frame.origin.y + self.categoryapp.frame.size.height, self.downloadNumLbl.frame.size.width, 15);
        self.rateView.frame = CGRectMake(self.categoryapp.frame.origin.x, self.categoryapp.frame.origin.y + self.categoryapp.frame.size.height + PADDING, 14.0f*7, 14.0f);
    }
    
    [self.Number setText:number];
    
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
//    CGRect frameCate = self.categoryapp.frame;
//    DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(frameCate.origin.x, frameCate.origin.y + frameCate.size.height, frameCate.size.width, frameCate.size.height)];
    //self.rateView.frame = CGRectMake(frameCate.origin.x, frameCate.origin.y + PADDING, 14.0f*7, 14.0f);
    self.rateView.rate = [_apprecord.rate intValue];
    self.downloadNumLbl.text = [NSString stringWithFormat:@"(%@)", _apprecord.downloads];
   }
@end
