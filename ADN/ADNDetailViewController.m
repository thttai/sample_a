//
//  ADNDetailViewController.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "ADNDetailViewController.h"
#import "DetailScreenShotCell.h"

@interface ADNDetailViewController()<RKManagerDelegate, DetailScreenShotCellProtocol>
{
CellDescriptionappdetail *myClass;
}

@end
int checkdescription=1;
@implementation ADNDetailViewController
@synthesize titlenav;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _heightcelldescription= 135;
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:titlenav style:UIBarButtonItemStylePlain target:nil action:nil];
    [[self tableviewdetail]setDelegate:self];
    [[self tableviewdetail]setDataSource:self];
    if (![_detailapprecord.des isKindOfClass:[NSString class]] || _detailapprecord.des.length == 0) {
        [[APIManager sharedAPIManager] RK_RequestApiGetAppDetail:self.detailapprecord.package appID:self.detailapprecord.app_id withContext:self];
    }
//        NSLog(@"%@",_detailapprecord.des);
   // NSLog(@"%@",_detailapprecord.name);
}

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0)
    {
       NSString *CellIdentifier   = CellIdentifier = @"Celldetail";
      CellDetailapp *cell = (CellDetailapp *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
        if(!cell)
        {
            cell = [[CellDetailapp alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        };
    

        [cell setApprecorddetail:_detailapprecord];
        [cell getdetailcontent];
        [cell.btprice addTarget:self action:@selector(handleUpdateVersion:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else if (indexPath.row==1) // cell show app's screenshots
    {
        NSString *CellIdentifier   = [[DetailScreenShotCell class] description];
        DetailScreenShotCell *cell = (DetailScreenShotCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(!cell)
        {
            cell = [[DetailScreenShotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.delegate = self;
        [cell setObject:_detailapprecord];
        return cell;
    }
    else if (indexPath.row==2)
    {
        NSString *CellIdentifier =@"CellDescriptionappdetail";
       CellDescriptionappdetail *cell = (CellDescriptionappdetail *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.delegate=self;
              if(!cell)
        {
            cell = [[CellDescriptionappdetail alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        };
        
        
        if (cell)
        {
            
            [cell getdescription:[self  convertHTML:_detailapprecord.des]];
        }
        return cell;
    }
    else if (indexPath.row==3)
    {
        NSString *CellIdentifier  = CellIdentifier = @"Cellratingpoint";
        Cellratingpoint *cell = (Cellratingpoint *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if(!cell)
        {
            cell = [[Cellratingpoint alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        };
        
        // NSString *indexrow = [NSString stringWithFormat:@"%d",indexPath.row];
        if (cell)
        {

            [cell getratepoint:_detailapprecord.rate :_detailapprecord.ratings];
            
        }
        return cell;
    }

      return nil;
}

#pragma mark
#pragma TableViewDelegate
#pragma mark TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 120;
    }
    else if (indexPath.row == 1) {
        return [DetailScreenShotCell tableView:tableView rowHeightForObject:nil];
    } else if (indexPath.row == 2) {
        
        return _heightcelldescription;
        
    }
    return 157;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleUpdateVersion:(id)sender
{
    // get indexpath button
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_detailapprecord.official_link]];
}

- (void)taskComplete:(float)complete;
{
    _heightcelldescription =complete;
    [_tableviewdetail reloadData];
}

-(NSString *)convertHTML:(NSString *)html
{
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}


#pragma mark - DetailScreenShotCellProtocol
-(void)screenShotCell:(DetailScreenShotCell *)cell didScroll:(UIScrollView *)scrollView
{
    // move screenshot cell to center of screen
    CGFloat cellHeight = [self heightToScrollTable:_tableviewdetail inRow:1];
    [UIView animateWithDuration:0.3 animations:^{
        self.tableviewdetail.contentOffset = CGPointMake(0, cellHeight);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    checkdescription=1;
}

-(CGFloat)heightToScrollTable:(UITableView *)myTable inRow:(int)section
{
    if (myTable == nil || section == 0) {
        return 0;
    }
    
    NSInteger height = 0;
    for (int i = 0; i < section; i++) {
        height += [self tableView:myTable heightForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    return height;
}

#pragma mark -
#pragma mark RKManageDelegate callback method
-(void)processResultResponseDictionaryMapping:(DictionaryMapping *)dictionary requestId:(int)request_id
{
    if (request_id == ID_REQUEST_GET_APP_DETAIL) {
        if (dictionary.curDictionary) {
            [self.detailapprecord setTrailer:[dictionary.curDictionary objectForKey:@"trailer"]];
            [self.detailapprecord setDes:[dictionary.curDictionary objectForKey:@"des"]];
            [self.detailapprecord setImages:[dictionary.curDictionary objectForKey:@"images"]];
            [self.detailapprecord setRatings:[dictionary.curDictionary objectForKey:@"ratings"]];
        }
    }
    [self.tableviewdetail reloadData];
}


@end
