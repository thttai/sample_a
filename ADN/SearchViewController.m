//
//  SearchViewController.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/26/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "SearchViewController.h"
#import "Celllistapp.h"
#import "ADNDetailViewController.h"

@interface SearchViewController ()<UISearchBarDelegate, RKManagerDelegate>
@property (strong, nonatomic) NSArray *searchResults;
@property (nonatomic, assign) BOOL isFilterSearch;
@end

@implementation SearchViewController

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
    [[self tableviewsearch]setDelegate:self];
    [[self tableviewsearch]setDataSource:self];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"ADN" style:UIBarButtonItemStylePlain target:nil action:nil];
   [self.searchbar becomeFirstResponder];
    _isFilterSearch = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)filterContentForSearchText: (NSString *) searchText
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", searchText];
    self.searchResults = [self.dataArray filteredArrayUsingPredicate:resultPredicate];
    _isFilterSearch = YES;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isFilterSearch) {
        return [_searchResults count];
    }
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    Celllistapp *cell = (Celllistapp *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(!cell)
    {
        cell = [[Celllistapp alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    };
    
    NSString *indexrow = [NSString stringWithFormat:@"%d",(int)indexPath.row + 1];
    if (cell)
    {
        if (_isFilterSearch)
        {
            [cell setApprecord:[self.searchResults objectAtIndex:indexPath.row]];
        }
        else
        {
            [cell setApprecord:[self.dataArray objectAtIndex:indexPath.row]];
        }
        [cell CustomCell:indexrow];
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
    ADNDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];    
    Apprecord *temp = [self.dataArray objectAtIndex:indexPath.row];
    
    if (_isFilterSearch)
    {
        temp = [self.searchResults objectAtIndex:indexPath.row];
    }
    [detail setDetailapprecord:temp];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark -
#pragma mark UISearchBarDelegate method
#pragma mark -
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        return;
    }
    [self filterContentForSearchText:searchText];[self.searchbar becomeFirstResponder];
    if ([_searchResults count] == 0) {
        [[APIManager sharedAPIManager] RK_RequestApiGetListAppBySearchKey:searchBar.text withContext:self];
    } else {
        [self.tableviewsearch reloadData];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    [_searchbar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_searchbar resignFirstResponder];
}

#pragma mark -
#pragma mark RKManageDelegate method
- (void)processResultResponseArray:(NSArray *)array requestId:(int)request_id
{
    if (request_id == ID_REQUEST_GET_LIST_APP_BY_SEARCH_KEY)
    {
        _searchResults = [NSMutableArray arrayWithArray:array];
    }
    [_tableviewsearch reloadData];
}
@end
