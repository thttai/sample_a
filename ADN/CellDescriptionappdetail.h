//
//  CellDescriptionappdetail.h
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellDescriptionappdetail : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
-(void)getdescription :(NSString *)description;
@end
