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
#import "FXBlurView.h"

#define TIME_CHANGE_BANNER 5
#define HOME_TABLE_CELL_HEIGHT 84

typedef enum
{
    ENUM_ADN_CATEGORY_TYPE_FAVORITE = 0,
    ENUM_ADN_CATEGORY_TYPE_DOWNLOAD,
    ENUM_ADN_CATEGORY_TYPE_TREND,
    ENUM_ADN_CATEGORY_TYPE_NUM
}ENUM_ADN_CATEGORY_TYPE;

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *segmentedView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Segment;
@property (weak, nonatomic) IBOutlet UITableView *Tableviewlistapp;
@property (strong, nonatomic) NSMutableArray *MutableArrayListApp;
@property (strong, nonatomic) NSMutableArray *MutableArrayListAppseg1;
@property (strong, nonatomic) NSMutableArray *MutableArrayListAppseg2;
@property (strong, nonatomic) NSMutableArray *MutableArrayListAppseg3;
@property (strong, nonatomic) NSMutableArray *MutableArrayListCategory;
@property (strong, nonatomic) Apprecord *apprecord;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
 
- (IBAction)btsegemented:(id)sender;

@end
