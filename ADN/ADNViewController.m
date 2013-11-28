//
//  ViewController.m
//  ADN
//
//  Created by Le Ngoc Duy on 11/19/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)


#import "ADNViewController.h"
#import "ADN_APIManager.h"
#import "CellBanner.h"
#import "UIViewController+CustomNavigation.h"
#import "UIViewController+TabBarAnimation.h"


@interface ADNViewController ()<RKManagerDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIScrollView *bannerScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControlView;

@end

@implementation ADNViewController {
    ENUM_ADN_CATEGORY_TYPE checkcat_id;
}

- (void)dealloc {
    [_mutableArrayListApp removeAllObjects];
    [_mutableArrayListAppseg1 removeAllObjects];
    [_mutableArrayListAppseg2 removeAllObjects];
    [_mutableArrayListAppseg3 removeAllObjects];
    [_mutableArrayListCategory removeAllObjects];
    
    _mutableArrayListApp = nil;
    _mutableArrayListAppseg1 = nil;
    _mutableArrayListAppseg2 = nil;
    _mutableArrayListAppseg3 = nil;
    _mutableArrayListCategory = nil;
}

- (void)viewDidLoad
{
    UIBarButtonItem *btSearch = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(actionSearch:)];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects: btSearch, nil];
    self.navigationItem.rightBarButtonItems = myButtonArray;
    checkcat_id=0;
    _mutableArrayListApp = [[NSMutableArray alloc]init];
    _mutableArrayListAppseg1 = [[NSMutableArray alloc]init];
    _mutableArrayListAppseg2 = [[NSMutableArray alloc]init];
    _mutableArrayListAppseg3 = [[NSMutableArray alloc]init];
    _mutableArrayListCategory = [[NSMutableArray alloc]init];
    [[ADN_APIManager sharedAPIManager] RK_RequestApiGetListCategoryContext:self];
    [super viewDidLoad];
    [[self tableViewListApp]setDelegate:self];
    [[self tableViewListApp]setDataSource:self];
    // set blur radius for segmented view
    self.segmentedView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.97f];
    [self performHideTabBar];
//    [self setCustomBarRightWithImage:[UIImage imageNamed:@"down.png"] selector:@selector(processActionSearch) context_id:self];
}

//-(void)processActionSearch
//{
//    NSLog(@"----Process search here-----");
//}

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
    return [_mutableArrayListApp count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //story board
    NSString *cellIdentifier = @"Cellsearch";
    Celllistapp *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = (Celllistapp *) [[[NSBundle mainBundle] loadNibNamed:@"CellListApp" owner:self options:nil] lastObject];
    }
    NSString *indexrow = [NSString stringWithFormat:@"%d",(int)indexPath.row + 1];
    if (cell)
    {
        [cell setAppRecord:[self.mutableArrayListApp objectAtIndex:indexPath.row]];
        [cell customCell:indexrow];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    return cell;
}

#pragma mark - TableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HOME_TABLE_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ADNDetailViewController *detail = [[ ADNDetailViewController alloc] initWithNibName:@"ADNDetailViewController" bundle:[NSBundle mainBundle]];
    Apprecord *temp = [self.mutableArrayListApp objectAtIndex:indexPath.row];
    [detail setDetailAppRecord:temp];
    if(_segment.selectedSegmentIndex == 0)
    {
      [detail setTitleNav:[_segment titleForSegmentAtIndex:0]];
    }
    else if(_segment.selectedSegmentIndex == 1)
    {
          [detail setTitleNav:[_segment titleForSegmentAtIndex:1]];
    }
    else if(_segment.selectedSegmentIndex == 2)
    {
        [detail setTitleNav:[_segment titleForSegmentAtIndex:2]];
    }
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.bannerScrollView && !self.bannerView.hidden)
    {
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
    if (scrollView == self.tableViewListApp) {
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
- (IBAction)btSegemented:(id)sender {
    checkcat_id = self.segment.selectedSegmentIndex;
    [self processListCatagory];
    [_tableViewListApp reloadData];

}

- (void) actionSearch:(id)sender {
    ADNSearchViewController *search = [[ADNSearchViewController alloc] initWithNibName:[[ADNSearchViewController class] description] bundle:nil];
    [search setDataArray:nil];
    [self.navigationController pushViewController:search animated:YES];
}
- (void) actionDownload:(id)sender {
//    NSLog(@"click download");
}

#pragma mark - Helper Methods

-(void)processListCatagory
{
    // Load data for correspond category ID
    
    BOOL isDataLoaded = NO;
    switch (checkcat_id) {
        case ENUM_ADN_CATEGORY_TYPE_FAVORITE: {
            if ([self.mutableArrayListAppseg1 count] > 0) {
                self.mutableArrayListApp = self.mutableArrayListAppseg1;
                isDataLoaded = YES;
            }
            break;
        }
        case ENUM_ADN_CATEGORY_TYPE_DOWNLOAD: {
            if ([self.mutableArrayListAppseg2 count] > 0) {
                self.mutableArrayListApp = self.mutableArrayListAppseg2;
                isDataLoaded = YES;
            }
            break;
        }
        case ENUM_ADN_CATEGORY_TYPE_TREND: {
            if ([self.mutableArrayListAppseg3 count] > 0) {
                self.mutableArrayListApp = self.mutableArrayListAppseg3;
                isDataLoaded = YES;
            }
            break;
        }
        default:
            break;
    }
    
    if (!isDataLoaded) {
        AppCategory *temp  =  [self.mutableArrayListCategory objectAtIndex:checkcat_id];
        int cat_id = [temp.cat_id intValue];
        [_segment setTitle:temp.name forSegmentAtIndex:checkcat_id];
        [[ADN_APIManager sharedAPIManager] RK_RequestApiGetListAppByCategory:cat_id withContext:self];
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
    AppCategory *temp = [_mutableArrayListCategory objectAtIndex:_segment.selectedSegmentIndex];
    if (temp.banner)
    {
        self.bannerView.hidden = NO;
        self.tableViewListApp.contentInset = UIEdgeInsetsMake(162, 0, 0, 0); // has banner view
        self.tableViewListApp.scrollIndicatorInsets = self.tableViewListApp.contentInset;
        [self addBanner:temp.banner];
        
        // update banner position
        [self scrollViewDidScroll:self.tableViewListApp];
        
    } else {
        self.bannerView.hidden = YES;
        self.tableViewListApp.contentInset = UIEdgeInsetsMake(44, 0, 0, 0); // doesn't have banner view
        self.tableViewListApp.scrollIndicatorInsets = self.tableViewListApp.contentInset;
        
    }
}

#pragma mark -
#pragma mark RKManageDelegate
#pragma mark -
-(void)processResultResponseArray:(NSArray *)array requestId:(int)request_id
{
    if (request_id == ID_REQUEST_GET_CATEGORY) {
        self.mutableArrayListCategory = [NSMutableArray arrayWithArray:array];
        
        // Fill text into Segment buttons
        for (int i= 0; i < ENUM_ADN_CATEGORY_TYPE_NUM;i++) {
            AppCategory *temp  =  [self.mutableArrayListCategory objectAtIndex:i];
            [_segment setTitle:temp.name forSegmentAtIndex:i];
        }
        
        [self processListCatagory];
        return;
    } else if (request_id == ID_REQUEST_GET_LIST_APP_BY_CATEGORY ) {
        switch (checkcat_id) {
            case ENUM_ADN_CATEGORY_TYPE_FAVORITE: {
                _mutableArrayListAppseg1 = [NSMutableArray arrayWithArray:array];
                _mutableArrayListApp = _mutableArrayListAppseg1;
                break;
            }
            case ENUM_ADN_CATEGORY_TYPE_DOWNLOAD: {
                _mutableArrayListAppseg2 = [NSMutableArray arrayWithArray:array];
                _mutableArrayListApp = _mutableArrayListAppseg2;
                break;
            }
            case ENUM_ADN_CATEGORY_TYPE_TREND: {
                _mutableArrayListAppseg3 = [NSMutableArray arrayWithArray:array];
                _mutableArrayListApp = _mutableArrayListAppseg3;
                break;
            }
            default: {
                break;
            }
        }
    }
    [_tableViewListApp reloadData];
}
@end
