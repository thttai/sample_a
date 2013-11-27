//
//  CellDescriptionappdetail.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "CellDescriptionappdetail.h"

#define DESCRIPTION_WIDTH 293.0f
#define DESCRIPTION_SHORT_HEIGHT 85.0f

@implementation CellDescriptionappdetail
@synthesize delegate;
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

+ (NSDictionary*)tableView:(UITableView*)tableView rowHeightForObject:(id)object forStatus:(enumDescriptionCellStatus)status
{
    NSString *text = object;
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(DESCRIPTION_WIDTH, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat height = size.height;
    if (height > 0) {
        if (height <= DESCRIPTION_SHORT_HEIGHT || status == enumDescriptionCellStatus_Full) {
            height += 35;
            // update status
            status = status == enumDescriptionCellStatus_Num ? enumDescriptionCellStatus_Full : status;
        }
        else // status == enumDescriptionCellStatus_Short  or undefine status
        {
            height = DESCRIPTION_SHORT_HEIGHT + 35;
            // update status
            status = status == enumDescriptionCellStatus_Num ? enumDescriptionCellStatus_Short :status;
        }
    }
    
    // return updated status and height
    return [NSDictionary dictionaryWithObjectsAndKeys:@(height), @"height", @(status), @"status", nil];
}

- (IBAction)btmore:(id)sender {
    self.uibtmore.selected = !self.uibtmore.selected;
    [delegate statusChanged:self.uibtmore.selected ? enumDescriptionCellStatus_Full : enumDescriptionCellStatus_Short];
}

- (void)setObject:(id)object forState:(enumDescriptionCellStatus)status
{
    self.lbDescription.text = object;
    _cellState = status;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.uibtmore.hidden = NO;
    CGSize size = [self.lbDescription.text sizeWithFont:self.lbDescription.font constrainedToSize:CGSizeMake(DESCRIPTION_WIDTH, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect r = self.lbDescription.frame;
     CGRect b = self.uibtmore.frame;
    if (size.height <= DESCRIPTION_SHORT_HEIGHT || _cellState == enumDescriptionCellStatus_Full) {
        r.size.height = size.height;
        self.lbDescription.numberOfLines = 0;
        self.uibtmore.hidden = NO;
        b.origin.y = size.height+10;
        if (r.size.height < DESCRIPTION_SHORT_HEIGHT) {
            self.uibtmore.hidden = YES;
        }

   [_uibtmore setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
    }
    else
    {
        r.size.height = DESCRIPTION_SHORT_HEIGHT;
         b.origin.y = DESCRIPTION_SHORT_HEIGHT+10;
        self.lbDescription.numberOfLines = 5;
        self.uibtmore.hidden = NO;
               [_uibtmore setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
    }
    self.lbDescription.frame = r;
    self.uibtmore.frame=b;
    if ([_lbDescription.text isEqualToString:@""])
    {
        self.uibtmore.hidden = YES;
    }
}
@end
