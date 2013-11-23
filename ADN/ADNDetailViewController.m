//
//  ADNDetailViewController.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "ADNDetailViewController.h"
@interface ADNDetailViewController()<RKManagerDelegate>

@end

@implementation ADNDetailViewController

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
    [[self tableviewdetail]setDelegate:self];
    [[self tableviewdetail]setDataSource:self];
    [[APIManager sharedAPIManager] RK_RequestApiGetAppDetail:self.detailapprecord.package appID:self.detailapprecord.app_id withContext:self];
        NSLog(@"%@",_detailapprecord.des);
   // NSLog(@"%@",_detailapprecord.name);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
//    if(_SegmentDetail.selectedSegmentIndex==0)
//    {
//
//       
//    }
//    else if (_SegmentDetail.selectedSegmentIndex==1)
//    {
//        
//        
//       
//    }

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
    
   // NSString *indexrow = [NSString stringWithFormat:@"%d",indexPath.row];
    if (cell)
    {
        
        [cell setApprecorddetail:_detailapprecord];
        [cell getdetailcontent];
        [cell.btprice addTarget:self action:@selector(handleUpdateVersion:) forControlEvents:UIControlEventTouchUpInside];
    }
        return cell;
    }
    
    else if (indexPath.row==1)
    {
        NSString *CellIdentifier   = CellIdentifier = @"CellBanner";
        CellBanner *cell = (CellBanner *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if(!cell)
        {
            cell = [[CellBanner alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        };
        if (cell)
        {
            
            [cell setDataSourceScrollView:_detailapprecord.images withKey:@"f"];
//            [cell getdetailcontent];
        }
        return cell;
    }
    else if (indexPath.row==2)
    {
        NSString *CellIdentifier   = CellIdentifier = @"CellDescriptionappdetail";
       CellDescriptionappdetail *cell = (CellDescriptionappdetail *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if(!cell)
        {
            cell = [[CellDescriptionappdetail alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        };
        
        // NSString *indexrow = [NSString stringWithFormat:@"%d",indexPath.row];
        if (cell)
        {
            
//            NSArray *paragraphs = [_detailapprecord.des componentsSeparatedByString: @"<p>"]; // still includes </p>
//            for (NSString *singleParagraph in paragraphs) {
//                
//               singleParagraph = [paragraphs
//            }
//            NSLog(@"%@",_detailapprecord.des);
          
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
    if (indexPath.row == 1) {
        return 119;
    } else if (indexPath.row == 2) {
        return 134;
    }
    return 157;
}


- (IBAction)btsegemented:(id)sender {
//    switch (self.SegmentDetail.selectedSegmentIndex) {
//            
//            NSLog(@"Changesegment");
//    }
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
-(NSString *)convertHTML:(NSString *)html {
    
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
