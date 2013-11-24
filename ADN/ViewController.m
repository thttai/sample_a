//
//  ViewController.m
//  ADN
//
//  Created by Le Ngoc Duy on 11/19/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)


#import "ViewController.h"
#import "APIManager.h"
#import "CellBanner.h"


@interface ViewController ()<RKManagerDelegate>
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIScrollView *bannerScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControlView;

@end

@implementation ViewController {
    ENUM_ADN_CATEGORY_TYPE checkcat_id;
}

- (void)dealloc {
    [_MutableArrayListApp removeAllObjects];
    [_MutableArrayListAppseg1 removeAllObjects];
    [_MutableArrayListAppseg2 removeAllObjects];
    [_MutableArrayListAppseg3 removeAllObjects];
    [_MutableArrayListCategory removeAllObjects];
    
    _MutableArrayListApp = nil;
    _MutableArrayListAppseg1 = nil;
    _MutableArrayListAppseg2 = nil;
    _MutableArrayListAppseg3 = nil;
    _MutableArrayListCategory = nil;
}

- (void)viewDidLoad
{
     UIBarButtonItem *btdownload = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actiondownload:)];
    UIBarButtonItem *btsearch = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(actionsearch:)];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects: btdownload,btsearch, nil];
    self.navigationItem.rightBarButtonItems = myButtonArray;
    checkcat_id=0;
    _MutableArrayListApp = [[NSMutableArray alloc]init];
    _MutableArrayListAppseg1 = [[NSMutableArray alloc]init];
    _MutableArrayListAppseg2 = [[NSMutableArray alloc]init];
    _MutableArrayListAppseg3 = [[NSMutableArray alloc]init];
    _MutableArrayListCategory = [[NSMutableArray alloc]init];
    [[APIManager sharedAPIManager] RK_RequestApiGetListCategoryContext:self];
    [super viewDidLoad];
    [[self Tableviewlistapp]setDelegate:self];
    [[self Tableviewlistapp]setDataSource:self];
    
    // set blur radius for segmented view
    self.segmentedView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.97f];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [_MutableArrayListApp count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *CellIdentifier = @"Cell";
    Celllistapp *cell = (Celllistapp *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
    if(!cell)
    {
          cell = [[Celllistapp alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    };
    
    NSString *indexrow = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    if (cell)
    {
        if(_Segment.selectedSegmentIndex==0)
        {
            [cell setApprecord:[self.MutableArrayListApp objectAtIndex:indexPath.row]];
            [cell CustomCell:indexrow];
            [cell.btPrice addTarget:self action:@selector(handleUpdateVersion:) forControlEvents:UIControlEventTouchUpInside];

        }
        else if(_Segment.selectedSegmentIndex==1)
        {
            [cell setApprecord:[self.MutableArrayListApp objectAtIndex:indexPath.row]];
            [cell CustomCell:indexrow];
        }
        else if(_Segment.selectedSegmentIndex==2)
        {
            [cell setApprecord:[self.MutableArrayListApp objectAtIndex:indexPath.row]];
            [cell CustomCell:indexrow];
        }
    }
    return cell;
}

#pragma mark - TableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HOME_TABLE_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ADNDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    // NSLog(@"----self.navigationController = %@", self.navigationController);
    
    Apprecord *temp = [self.MutableArrayListApp objectAtIndex:indexPath.row];
    
    [detail setDetailapprecord:temp];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollViewDidEndDecelerating-0");
    if (scrollView == self.bannerScrollView && !self.bannerView.hidden) {
        CGRect frame = self.bannerScrollView.frame;
        CGPoint contentOffset = self.bannerScrollView.contentOffset;
        int currentPage = contentOffset.x/frame.size.width;
        if (self.pageControlView.currentPage == currentPage) {
            return;
        }
        self.pageControlView.currentPage = currentPage;
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(executeChangeBanner) withObject:Nil afterDelay:TIME_CHANGE_BANNER];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewWillBeginDragging-1");
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"scrollViewDidEndDragging-2");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewDidScroll-3 %f", scrollView.contentOffset.y);
    // update header position
    if (scrollView == self.Tableviewlistapp) {
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat insetTop = scrollView.contentInset.top;
        if (offsetY > -insetTop) {
            
            // follow table
            CGRect r = _bannerView.frame;
            r.origin.y = 44 - (offsetY + insetTop);
            _bannerView.frame = r;
        }
        else {
            CGRect r = _bannerView.frame;
            r.origin.y = 44;
            _bannerView.frame = r;
        }
    }
}

#pragma mark - View Actions
- (IBAction)btsegemented:(id)sender {
    checkcat_id = self.Segment.selectedSegmentIndex;
    [self processlistcatagory];
    [_Tableviewlistapp reloadData];

}

- (void) actionsearch:(id)sender {
    NSLog(@"click search");
    
}
- (void) actiondownload:(id)sender {
    NSLog(@"click download");
}

- (void)handleUpdateVersion:(id)sender
{
    // get indexpath button
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.Tableviewlistapp];
    NSIndexPath *indexPath = [self.Tableviewlistapp indexPathForRowAtPoint:buttonPosition];
    
    Apprecord * temp = [self.MutableArrayListApp objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:temp.official_link]];
}

#pragma mark - Helper Methods

-(void)processlistcatagory
{
    // Load data for correspond category ID
    
    BOOL isDataLoaded = NO;
    switch (checkcat_id) {
        case ENUM_ADN_CATEGORY_TYPE_FAVORITE: {
            if ([self.MutableArrayListAppseg1 count] > 0) {
                self.MutableArrayListApp = self.MutableArrayListAppseg1;
                isDataLoaded = YES;
            }
            break;
        }
        case ENUM_ADN_CATEGORY_TYPE_DOWNLOAD: {
            if ([self.MutableArrayListAppseg2 count] > 0) {
                self.MutableArrayListApp = self.MutableArrayListAppseg2;
                isDataLoaded = YES;
            }
            break;
        }
        case ENUM_ADN_CATEGORY_TYPE_TREND: {
            if ([self.MutableArrayListAppseg3 count] > 0) {
                self.MutableArrayListApp = self.MutableArrayListAppseg3;
                isDataLoaded = YES;
            }
            break;
        }
        default:
            break;
    }
    
    if (!isDataLoaded) {
        AppCategory *temp  =  [self.MutableArrayListCategory objectAtIndex:checkcat_id];
        int cat_id = [temp.cat_id intValue];
        [_Segment setTitle:temp.name forSegmentAtIndex:checkcat_id];
        [[APIManager sharedAPIManager] RK_RequestApiGetListAppByCategory:cat_id withContext:self];
    }
    
    // Update banner view
    [self updateBannerView];
}

#pragma mark - Banner Methods

-(void)executeChangeBanner
{
    if (self.bannerView.hidden) {
        return;
    }
    CGRect frame = self.bannerScrollView.frame;
    CGPoint contentOffset = self.bannerScrollView.contentOffset;
    CGFloat xMax = frame.size.width * (self.bannerScrollView.subviews.count - 1);
    //check next coordinate x to move
    if (contentOffset.x == xMax) {
        contentOffset.x = 0;
    }  else {
        contentOffset.x += frame.size.width;
    }
    int currentPage = contentOffset.x/frame.size.width;
    self.pageControlView.currentPage = currentPage;
    [UIView animateWithDuration:0.5 animations:^{
        [self.bannerScrollView setContentOffset:contentOffset];
    } completion:^(BOOL finished) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(executeChangeBanner) withObject:Nil afterDelay:TIME_CHANGE_BANNER];
    }];
}

- (IBAction)changePage:(id)sender
{
    [self executeChangeBanner];    // YES = animate
}

-(void)addBanner:(NSMutableArray *)array
{
    //    NSLog(@"-----self.myScrollView.subviews.count = %d",self.myScrollView.subviews.count);
    if (self.bannerScrollView.subviews.count > 0) {
        [self.bannerScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    CGRect frame = self.bannerScrollView.frame;
    for (int i = 0; i < array.count; i++)
    {
        NSDictionary *dic = [array objectAtIndex:i];
        NSString *url = (NSString *)[dic objectForKey:@"image"];
        SDImageView *imgView = [[SDImageView alloc] initWithFrame:CGRectMake(frame.origin.x + i*frame.size.width, frame.origin.y, frame.size.width, frame.size.height)];
        [self.bannerScrollView addSubview:imgView];
        [imgView setImageWithURL:[NSURL URLWithString:url]];
    }
    self.pageControlView.numberOfPages = array.count;
    self.pageControlView.currentPage = 0;
    self.bannerScrollView.pagingEnabled = YES;
    self.bannerScrollView.contentSize = CGSizeMake(frame.size.width * array.count, 0);//disable scroll vertical
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(executeChangeBanner) withObject:Nil afterDelay:TIME_CHANGE_BANNER];
}

-(void)updateBannerView
{
    AppCategory *temp = [_MutableArrayListCategory objectAtIndex:_Segment.selectedSegmentIndex];
    if (temp.banner)
    {
        self.bannerView.hidden = NO;
        self.Tableviewlistapp.contentInset = UIEdgeInsetsMake(162, 0, 0, 0); // has banner view
        self.Tableviewlistapp.scrollIndicatorInsets = self.Tableviewlistapp.contentInset;
        [self addBanner:temp.banner];
        
        // update banner position
        [self scrollViewDidScroll:self.Tableviewlistapp];
        
    } else {
        self.bannerView.hidden = YES;
        self.Tableviewlistapp.contentInset = UIEdgeInsetsMake(44, 0, 0, 0); // doesn't have banner view
        self.Tableviewlistapp.scrollIndicatorInsets = self.Tableviewlistapp.contentInset;
        
    }
}

#pragma mark -
#pragma mark RKManageDelegate
#pragma mark -
-(void)processResultResponseArray:(NSArray *)array requestId:(int)request_id
{
    if (request_id == ID_REQUEST_GET_CATEGORY) {
        self.MutableArrayListCategory = [NSMutableArray arrayWithArray:array];
        
        // Fill text into Segment buttons
        for (int i= 0; i < ENUM_ADN_CATEGORY_TYPE_NUM;i++) {
            AppCategory *temp  =  [self.MutableArrayListCategory objectAtIndex:i];
            [_Segment setTitle:temp.name forSegmentAtIndex:i];
        }
        
        [self processlistcatagory];
        
        [self.Tableviewlistapp reloadData];
        return;
    } else if (request_id == ID_REQUEST_GET_LIST_APP_BY_CATEGORY ) {
        switch (checkcat_id) {
            case ENUM_ADN_CATEGORY_TYPE_FAVORITE: {
                _MutableArrayListAppseg1 = [NSMutableArray arrayWithArray:array];
                _MutableArrayListApp = _MutableArrayListAppseg1;
                break;
            }
            case ENUM_ADN_CATEGORY_TYPE_DOWNLOAD: {
                _MutableArrayListAppseg2 = [NSMutableArray arrayWithArray:array];
                _MutableArrayListApp = _MutableArrayListAppseg2;
                break;
            }
            case ENUM_ADN_CATEGORY_TYPE_TREND: {
                _MutableArrayListAppseg3 = [NSMutableArray arrayWithArray:array];
                _MutableArrayListApp = _MutableArrayListAppseg3;
                break;
            }
            default: {
                break;
            }
        }
        [_Tableviewlistapp reloadData];
        return;
    }
}

@end
