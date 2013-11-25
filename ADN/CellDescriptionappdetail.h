//
//  CellDescriptionappdetail.h
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADNDetailViewController.h"
@protocol MyClassDelegate <NSObject>
// Required means if they want to use the delegate they
// have to implement it.
@required
- (void)taskComplete:(float)complete ;
@end
@interface CellDescriptionappdetail : UITableViewCell
{
   id<MyClassDelegate> delegate;
    
}

@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
@property (strong, nonatomic) IBOutlet UIView *uiviewdescription;
- (IBAction)btmore:(id)sender;
-(void)getdescription :(NSString *)description ;
@property (nonatomic, strong) id delegate;
@property (strong, nonatomic) IBOutlet UIButton *uibtmore;
@property float heightdescription;

@end
