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

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *segmentedView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Segment;
@property (weak, nonatomic) IBOutlet UITableView *Tableviewlistapp;
@property (strong, nonatomic) NSMutableArray *MutableArrayListApp;
@property (strong, nonatomic) NSMutableArray *MutableArrayListAppseg1;
@property (strong, nonatomic) NSMutableArray *MutableArrayListAppseg2;
@property (strong, nonatomic) NSMutableArray *MutableArrayListAppseg3;
@property (strong, nonatomic) NSMutableArray *MutableArrayListCategory;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) Apprecord *apprecord;

@property float getContentOffsetseg1;
@property float getContentOffsetseg2;
@property float getContentOffsetseg3;


- (IBAction)btsegemented:(id)sender;

@end
