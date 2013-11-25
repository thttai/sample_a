//
//  DetailScreenShotCell.m
//  ADN
//
//  Created by Tai Truong on 11/24/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "DetailScreenShotCell.h"

#define SCREENSHOT_WIDTH 200
#define SCREENSHOT_HEIGHT 350
#define SCREENSHOT_PADDING 14

@implementation DetailScreenShotCell
@synthesize object = __object;

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

#pragma mark - Public Methods

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 400;
}

-(id)object
{
    return __object;
}

-(void)setObject:(id)object
{
    __object = object;

    // remove all current image
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    Apprecord *detailRecord = object;
    // add new screen shot
    NSArray *arrImages = detailRecord.images;
    CGFloat x = SCREENSHOT_PADDING;
    for (NSDictionary *dic in arrImages) {
        NSString *imageURL = dic[@"f"];
        SDImageView *imageView = [[ SDImageView alloc] initWithFrame:CGRectMake(x, 0, SCREENSHOT_WIDTH, SCREENSHOT_HEIGHT)];
        [imageView setImageWithURL:[NSURL URLWithString:imageURL]];
        [self.scrollView addSubview:imageView];
        
        // increase x position
        x += SCREENSHOT_WIDTH + SCREENSHOT_PADDING;
        
    }
    
    if (arrImages) {
        CGSize contentSize = CGSizeMake(arrImages.count * (SCREENSHOT_WIDTH + SCREENSHOT_PADDING), 0);
        [self.scrollView setContentSize:contentSize];
    }
    
    NSString *downloadStr = [self stringForNumberDownload:detailRecord.downloads];
    NSString *dateStr = [self dateStringForDate:detailRecord.date_add];
    // info
    self.infoLbl.text = [NSString stringWithFormat:@"Lượt tải: %@ | %@ | %@",downloadStr, dateStr, detailRecord.size];
    
}

#pragma mark - Helper
-(NSString*)stringForNumberDownload:(NSString*)downloadNumberStr
{
    NSInteger numDownload = [downloadNumberStr integerValue];
    NSString *result = @"";
    if (numDownload < 1000) {
        result = downloadNumberStr;
    }
    else {
        NSInteger i = numDownload / 1000;
        NSInteger j = numDownload % 1000;
        result = j == 0? [NSString stringWithFormat:@"%dk", i] : [NSString stringWithFormat:@"%dk+", i];
        
    }
    return result;
}

-(NSString*)dateStringForDate:(NSString*)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateStr];
    formatter.dateFormat = @"dd/mm/yyyy";
    return [formatter stringFromDate:date];
}
#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(screenShotCell:didScroll:)]) {
        [self.delegate screenShotCell:self didScroll:scrollView];
    }
}

@end
