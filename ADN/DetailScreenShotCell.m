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
    return 380;
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
    
    // add new screen shot
    NSArray *arrImages = object;
    CGFloat x = SCREENSHOT_PADDING;
    for (NSDictionary *dic in arrImages) {
        NSString *imageURL = dic[@"f"];
        UIImageView *imageView = [[ UIImageView alloc] initWithFrame:CGRectMake(x, 0, SCREENSHOT_WIDTH, SCREENSHOT_HEIGHT)];
        [imageView setImageWithURL:[NSURL URLWithString:imageURL]];
        [self.scrollView addSubview:imageView];
        
        // increase x position
        x += SCREENSHOT_WIDTH + SCREENSHOT_PADDING;
        
    }
    
    if (arrImages) {
        CGSize contentSize = CGSizeMake(arrImages.count * (SCREENSHOT_WIDTH + SCREENSHOT_PADDING), 0);
        [self.scrollView setContentSize:contentSize];
    }
    
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(screenShotCell:didScroll:)]) {
        [self.delegate screenShotCell:self didScroll:scrollView];
    }
}

@end
