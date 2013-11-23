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

#define TIME_CHANGE_BANNER 5

@interface ViewController ()<RKManagerDelegate>
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIScrollView *bannerScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControlView;

@end

@implementation ViewController
int checkcat_id;
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

#pragma mark tableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    if(_Segment.selectedSegmentIndex==0)
    {
        //return array list 1
        return [_MutableArrayListApp count];
    }
    else if (_Segment.selectedSegmentIndex==1)
    {
        //return array list 2
        return [_MutableArrayListApp count];
    }
    else
        //return array list 3
        if (_Segment.selectedSegmentIndex==2)
        {
        return [_MutableArrayListApp count];
        }
    return 0;
   
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
#pragma mark TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

- (IBAction)btsegemented:(id)sender {
    switch (self.Segment.selectedSegmentIndex) {
            
        case 0:
            checkcat_id=0;
            [self processlistcatagory];
            [self.Tableviewlistapp setContentOffset:CGPointMake(0, _getContentOffsetseg1) animated:NO];
            [_Tableviewlistapp reloadData];
            break;
        case 1:
            checkcat_id=1;
            [self processlistcatagory];
            [self.Tableviewlistapp setContentOffset:CGPointMake(0,  _getContentOffsetseg2) animated:NO];
            [_Tableviewlistapp reloadData];
            break;
        case 2:     
            checkcat_id=2;
            [self processlistcatagory];
            [self.Tableviewlistapp setContentOffset:CGPointMake(0,  _getContentOffsetseg3) animated:NO];
            [_Tableviewlistapp reloadData];
            break;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating-0");
    if (scrollView == self.bannerScrollView) {
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
    NSLog(@"scrollViewWillBeginDragging-1");
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging-2");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll-3 %f", scrollView.contentOffset.y);
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
        
        if(_Segment.selectedSegmentIndex==0)
        {
            // get contenoffset segment 1
            _getContentOffsetseg1 =_Tableviewlistapp.contentOffset.y;
        }
        else if(_Segment.selectedSegmentIndex==1) {
            // get contenoffset segment 2
            _getContentOffsetseg2 =_Tableviewlistapp.contentOffset.y;
        }
        else if(_Segment.selectedSegmentIndex==2) {
            // get contenoffset segment 3
            _getContentOffsetseg3 =_Tableviewlistapp.contentOffset.y;
        }
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated
{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)processlistcatagory
{
    
    for (checkcat_id=checkcat_id; checkcat_id < [_MutableArrayListCategory count];){
        int i;
        for (i= 0; i < 3;i++)
        {
            AppCategory *temp  =  [self.MutableArrayListCategory objectAtIndex:i];
            [_Segment setTitle:temp.name forSegmentAtIndex:i];
        }
        if(checkcat_id==0)
        {
            AppCategory *temp  =  [self.MutableArrayListCategory objectAtIndex:checkcat_id];
            int cat_id = [temp.cat_id intValue];
            [_Segment setTitle:temp.name forSegmentAtIndex:checkcat_id];
            [[APIManager sharedAPIManager] RK_RequestApiGetListAppByCategory:cat_id withContext:self];
            checkcat_id=0;
            break;
        }
        else if(checkcat_id==1) {
            AppCategory *temp  =  [self.MutableArrayListCategory objectAtIndex:checkcat_id];
            int cat_id = [temp.cat_id intValue];
            [_Segment setTitle:temp.name forSegmentAtIndex:checkcat_id];
            [[APIManager sharedAPIManager] RK_RequestApiGetListAppByCategory:cat_id withContext:self];
            checkcat_id=cat_id;
            checkcat_id=1;
            break;
        }
        else if(checkcat_id==2) {
            AppCategory *temp  =  [self.MutableArrayListCategory objectAtIndex:checkcat_id];
            int cat_id = [temp.cat_id intValue];
            [_Segment setTitle:temp.name forSegmentAtIndex:checkcat_id];
            [[APIManager sharedAPIManager] RK_RequestApiGetListAppByCategory:cat_id withContext:self];
            checkcat_id=2;
            break;
        }
        
    }
    
    [self updateBannerView];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ADNDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    // NSLog(@"----self.navigationController = %@", self.navigationController);
    
    if(_Segment.selectedSegmentIndex==0)
    {
        Apprecord *temp = [self.MutableArrayListAppseg1 objectAtIndex:indexPath.row];
        
        [detail setDetailapprecord:temp];
        
    }
    else if(_Segment.selectedSegmentIndex==1)
    {
        Apprecord *temp = [self.MutableArrayListAppseg2 objectAtIndex:indexPath.row];
        
        [detail setDetailapprecord:temp];
    }
    else if(_Segment.selectedSegmentIndex==2)
    {
        Apprecord *temp = [self.MutableArrayListAppseg3 objectAtIndex:indexPath.row];
        
        [detail setDetailapprecord:temp];
    }
    
    [self.navigationController pushViewController:detail animated:YES];

}

#pragma mark - Banner Methods

-(void)executeChangeBanner
{
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
    [self performSelector:@selector(executeChangeBanner) withObject:Nil afterDelay:TIME_CHANGE_BANNER];
}

-(void)updateBannerView
{
    AppCategory *temp = [_MutableArrayListCategory objectAtIndex:_Segment.selectedSegmentIndex];
    if (temp.banner)
    {
        self.bannerView.hidden = NO;
        self.Tableviewlistapp.contentInset = UIEdgeInsetsMake(162, 0, 0, 0);
        self.Tableviewlistapp.scrollIndicatorInsets = self.Tableviewlistapp.contentInset;
        [self addBanner:temp.banner];
    } else {
        self.bannerView.hidden = YES;
        self.Tableviewlistapp.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
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
        [self.Tableviewlistapp reloadData];
        [self processlistcatagory];
        return;
    } else if (request_id == ID_REQUEST_GET_LIST_APP_BY_CATEGORY ) {
        self.MutableArrayListApp = [NSMutableArray arrayWithArray:array];
        NSArray *array1 = [NSArray arrayWithArray:_MutableArrayListApp];
        
        if  (checkcat_id==0)
        {
            NSArray *array2 = [NSArray arrayWithArray:_MutableArrayListAppseg1];
            if ([array1 isEqualToArray:array2])
            {
             //no new data
            }
            else
            {
                _MutableArrayListAppseg1=_MutableArrayListApp;
                [_Tableviewlistapp reloadData];
            }
            // checkcat_id=checkcat_id+1;
            //[self processlistcatagory];
        }
        else if  (checkcat_id==1)
        {
            NSArray *array2 = [NSArray arrayWithArray:_MutableArrayListAppseg2];
            if ([array1 isEqualToArray:array2])
            {
             //no new data
            }
            else
            {
                _MutableArrayListAppseg2=_MutableArrayListApp;
                [_Tableviewlistapp reloadData];
            }

                     // checkcat_id=checkcat_id+1;
            //[self processlistcatagory];
        }
        else if  (checkcat_id==2)
        {
            NSArray *array2 = [NSArray arrayWithArray:_MutableArrayListAppseg3];
            if ([array1 isEqualToArray:array2])
            {
                //no new data
            }
            else
            {
                _MutableArrayListAppseg3=_MutableArrayListApp;
                [_Tableviewlistapp reloadData];
            }

        }
        return;
    }
}

@end
