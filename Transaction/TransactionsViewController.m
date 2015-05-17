//
//  TransactionsViewController.m
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "TransactionsViewController.h"
#import "AuthService.h"
#import "PendingTransactionsService.h"
#import "User.h"
#import "Account.h"
#import "Transaction.h"
#import "TransactionDetailService.h"

@interface TransactionsViewController ()
@property (strong) AuthService *authService;
@property (strong) PendingTransactionsService *transactionService;
@property (strong) TransactionDetailService * transactionDetailService;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong) User *user;
@property (nonatomic) int page;
@end

@implementation TransactionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self initializeSearchController];
    
    
    
    NSArray *userResult = [self fetchEntity:@"User"];
    _page = 1;
    if ([userResult count] > 0) {
        _user = [userResult objectAtIndex:0];
        // Init service
        _transactionService = [[PendingTransactionsService alloc] initWithDelegate:self authtoken:_user.authtoken];
        [_transactionService getTransactionsPage:_page];
        
        _transactionDetailService = [[TransactionDetailService alloc] initWithDelegate:self authtoken:_user.authtoken];
        
    } else {
        _authService = [[AuthService alloc] initWithDelegate:self authtoken:nil];
        [_authService login:@"sn_checker" password:@"96e79218965eb72c92a549dd5a330112"];
    }
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:_refreshControl];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma search controller
- (void)initializeSearchController {
    
    //instantiate a search results controller for presenting the search/filter results (will be presented on top of the parent table view)
    UITableViewController *searchResultsController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    searchResultsController.tableView.dataSource = self;
    
    searchResultsController.tableView.delegate = self;
    
    //instantiate a UISearchController - passing in the search results controller table
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    
    //this view controller can be covered by theUISearchController's view (i.e. search/filter table)
    self.definesPresentationContext = YES;
    
    
    //define the frame for the UISearchController's search bar and tint
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    
    //add the UISearchController's search bar to the header of this table
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    
    //this ViewController will be responsible for implementing UISearchResultsDialog protocol method(s) - so handling what happens when user types into the search bar
    self.searchController.searchResultsUpdater = self;
    
    
    //this ViewController will be responsisble for implementing UISearchBarDelegate protocol methods(s)
    self.searchController.searchBar.delegate = self;
}

#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
//    //get search text from user input
//    NSString *searchText = [self.searchController.searchBar text];
//    
//    //exit if there is no search text (i.e. user tapped on the search bar and did not enter text yet)
//    if(![searchText length] > 0) {
//        
//        return;
//    }
//    //handle when there is search text entered by the user
//    else {
//        
//        //based on the user's search, we will update the contents of the tableSections and tableSectionsAndItems properties
//        [self.tableSections removeAllObjects];
//        
//        [self.tableSectionsAndItems removeAllObjects];
//        
//        
//        NSString *firstSearchCharacter = [searchText substringToIndex:1];
//        
//        //handle when user taps into search bear and there is no text entered yet
//        if([searchText length] == 0) {
//            
//            self.tableSections = [[Item fetchDistinctItemGroupsInManagedObjectContext:self.managedObjectContext] mutableCopy];
//            
//            self.tableSectionsAndItems = [[Item fetchItemNamesByGroupInManagedObjectContext:self.managedObjectContext] mutableCopy];
//        }
//        //handle when user types in one or more characters in the search bar
//        else if(searchText.length > 0) {
//            
//            //the table section will always be based off of the first letter of the group
//            NSString *upperCaseFirstSearchCharacter = [firstSearchCharacter uppercaseString];
//            
//            self.tableSections = [[[NSArray alloc] initWithObjects:upperCaseFirstSearchCharacter, nil] mutableCopy];
//            
//            
//            //there will only be one section (based on the first letter of the search text) - but the property requires an array for cases when there are multiple sections
//            NSDictionary *namesByGroup = [Item fetchItemNamesByGroupFilteredBySearchText:searchText inManagedObjectContext:self.managedObjectContext];
//            
//            self.tableSectionsAndItems = [[[NSArray alloc] initWithObjects:namesByGroup, nil] mutableCopy];
//        }
//        
//        //now that the tableSections and tableSectionsAndItems properties are updated, reload the UISearchController's tableview
//        [((UITableViewController *)self.searchController.searchResultsController).tableView reloadData];
//    }
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
//    [self.tableSections removeAllObjects];
//    
//    [self.tableSectionsAndItems removeAllObjects];
//    
//    self.tableSections = [[Item fetchDistinctItemGroupsInManagedObjectContext:self.managedObjectContext] mutableCopy];
//    
//    self.tableSectionsAndItems = [[Item fetchItemNamesByGroupInManagedObjectContext:self.managedObjectContext] mutableCopy];
}

#pragma mark UIsearch filter data
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    return YES;
}

#pragma mark refresh control
- (void)refresh:(UIRefreshControl *)refreshControl {
    [_transactionService getTransactionsPage:_page];
}

#pragma mark - Service response

- (void)startRequest:(BaseService *)service {
    if (service == _transactionDetailService) {
        // Show indicator
    }
}

- (void)successRequest:(BaseService *)service response:(NSDictionary *)data
{
    if (service == _authService && [_authService parser:data context:self.managedObjectContext]) {
        
    }
    if (service == _transactionService && [_transactionService parser:data context:nil]) {
        [_tableView reloadData];
        _page++;
    }
    
    if (service == _transactionDetailService && [_transactionDetailService parser:data context:nil]) {
        [_tableView reloadData];
    }
    [super successRequest:service response:data];
}

- (void)finishRequest:(BaseService *)service {
    if (service == _transactionService) {
        [_refreshControl endRefreshing];
    }
    
    if (service == _transactionDetailService) {
        // Hide indicator
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_transactionService.accounts == nil) {
        return 0;
    }
    return [_transactionService.accounts count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TransactionHeaderView *headerView = [tableView dequeueReusableCellWithIdentifier:@"header"];
    if (headerView == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"HeaderSectionView" bundle:nil] forCellReuseIdentifier:@"header"];
        headerView = [tableView dequeueReusableCellWithIdentifier:@"header"];

    }
    headerView.delegate = self;
    Account *account = [_transactionService.accounts objectAtIndex:section];
    [headerView cellWithData:account];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Account *account = [_transactionService.accounts objectAtIndex:indexPath.section];
    float titleHeight = 0.0f;
    if (indexPath.row == 0 || indexPath.row == account.transfers.count || indexPath.row == (account.transfers.count + account.batchs.count)) {
        titleHeight = 15.0f;
    }
    Transaction *transaction = nil;
    
    if (indexPath.row < account.transfers.count) {
        transaction = [account.transfers objectAtIndex:indexPath.row];
    } else if (indexPath.row >= account.transfers.count && indexPath.row < (account.transfers.count + account.batchs.count)) {
        transaction = [account.batchs objectAtIndex:(indexPath.row - account.transfers.count)];
    } else {
        transaction = [account.others objectAtIndex:(indexPath.row - account.transfers.count - account.batchs.count)];
        
    }
    return [TransactionTableViewCell heightForCellWithData:transaction] + titleHeight;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!_transactionService.accounts) return 0;
    Account *account = [_transactionService.accounts objectAtIndex:section];
    return account.transfers.count + account.batchs.count + account.others.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"transaction"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"TransactionTableViewCell" bundle:nil] forCellReuseIdentifier:@"transaction"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"transaction"];

    }
    cell.delegate = self;
    Account *account = [_transactionService.accounts objectAtIndex:indexPath.section];
    Transaction *transaction = nil;
    
    if (indexPath.row < account.transfers.count) {
        transaction = [account.transfers objectAtIndex:indexPath.row];
    } else if (indexPath.row >= account.transfers.count && indexPath.row < (account.transfers.count + account.batchs.count)) {
        transaction = [account.batchs objectAtIndex:(indexPath.row - account.transfers.count)];
    } else {
        transaction = [account.others objectAtIndex:(indexPath.row - account.transfers.count - account.batchs.count)];
        
    }
    
    [cell cellWithData:transaction];
    return cell;
}

#pragma mark cell and header delegate

- (void)requestDetail:(TransactionTableViewCell *)cell transaction:(Transaction *)transaction
{
    [_transactionDetailService getDetailTransaction:transaction approved:@"0"];
}

- (void)didChangeExpand {
    [_tableView reloadData];
}

- (void)didChangeCheckingValue {
    [_tableView reloadData];
}

- (void)didChangeButtonCheckAll:(TransactionHeaderView *)header {
    [_tableView reloadData];
}
@end
