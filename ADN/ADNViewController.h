//
//  ViewController.h
//  ADN
//
//  Created by Le Ngoc Duy on 11/19/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//
 
#import <UIKit/UIKit.h>
#import "Apprecord.h"
#import <QuartzCore/QuartzCore.h>
#import "Celllistapp.h"
#import "ADNDetailViewController.h"
#import "ADNSearchViewController.h"
#define TIME_CHANGE_BANNER 5

typedef enum
{
    ENUM_ADN_CATEGORY_TYPE_FAVORITE = 0,
    ENUM_ADN_CATEGORY_TYPE_DOWNLOAD,
    ENUM_ADN_CATEGORY_TYPE_TREND,
    ENUM_ADN_CATEGORY_TYPE_NUM
}ENUM_ADN_CATEGORY_TYPE;

@interface ADNViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *segmentedView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITableView *tableViewListApp;
@property (strong, nonatomic) NSMutableArray *mutableArrayListApp;
@property (strong, nonatomic) NSMutableArray *mutableArrayListAppseg1;
@property (strong, nonatomic) NSMutableArray *mutableArrayListAppseg2;
@property (strong, nonatomic) NSMutableArray *mutableArrayListAppseg3;
@property (strong, nonatomic) NSMutableArray *mutableArrayListCategory;
@property (strong, nonatomic) Apprecord *appRecord;
 
- (IBAction)btSegemented:(id)sender;

@end
