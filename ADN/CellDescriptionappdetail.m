//
//  CellDescriptionappdetail.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "CellDescriptionappdetail.h"

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

int checkdescription;

- (IBAction)btmore:(id)sender {
    [delegate taskComplete:_heightdescription];
    checkdescription=2;
}

-(void)getdescription :(NSString *)description;
{
 //   checkdescription = checkview;
    if (checkdescription==1){
        _lbDescription.text= description;
        _lbDescription.numberOfLines = 0;
        CGSize maximumLabelSize = CGSizeMake(280,9999);
        CGSize expectedLabelSize = [description sizeWithFont: _lbDescription.font
                                           constrainedToSize:maximumLabelSize
                                               lineBreakMode: _lbDescription.lineBreakMode];
        CGRect newFrame =  _lbDescription.frame;
        newFrame.size.height = expectedLabelSize.height+5;
       // _lbDescription.frame = newFrame;
        CGRect newFrame1 = self.uiviewdescription.frame;
        newFrame1.size.height =  newFrame.size.height+50;
        [self.uiviewdescription setFrame:newFrame1];
        _heightdescription =newFrame1.size.height;
        
    }
    else if(checkdescription==2)
    {
        _uibtmore.hidden=true;
        _lbDescription.text= description;
        _lbDescription.numberOfLines = 0;
        CGSize maximumLabelSize = CGSizeMake(280,9999);
        CGSize expectedLabelSize = [description sizeWithFont: _lbDescription.font
                                  constrainedToSize:maximumLabelSize
                                      lineBreakMode: _lbDescription.lineBreakMode];
        CGRect newFrame =  _lbDescription.frame;
        newFrame.size.height = expectedLabelSize.height+5;
        _lbDescription.frame = newFrame;
        CGRect newFrame1 = self.uiviewdescription.frame;
        newFrame1.size.height =  newFrame.size.height+50;
        [self.uiviewdescription setFrame:newFrame1];
        _heightdescription =newFrame1.size.height;
        checkdescription=3;
    }

}


@end
