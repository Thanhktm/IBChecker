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
#import "TransactionApprove.h"
#import "BCTableView.h"
#import "TransactionResultViewController.h"


@interface TransactionsViewController ()
@property (strong) AuthService *authService;
@property (strong) PendingTransactionsService *transactionService;
@property (strong) TransactionDetailService * transactionDetailService;
@property (strong) TransactionApprove * transactionApproveService;

@property (strong, nonatomic) IBOutlet BCTableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) IBOutlet UITextField *txtApproveCode;
@property (nonatomic) int page;
@end

@implementation TransactionsViewController
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self initializeSearchController];
    
    // Init service
    _transactionService = [[PendingTransactionsService alloc] initWithDelegate:self authtoken:_user.authtoken];
    
    _transactionDetailService = [[TransactionDetailService alloc] initWithDelegate:self authtoken:_user.authtoken];
    
    _transactionApproveService = [[TransactionApprove alloc] initWithDelegate:self authtoken:_user.authtoken];
    
    
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:_refreshControl];
    
    [self.tableView becomeFirstResponder];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTouchView)];
    
    [self.view addGestureRecognizer:recognizer];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setTitle:NSLocalizedString(@"Approve", @"")];
    _page = 1;
    [_transactionService getTransactionsPage:_page];


}

- (void)viewWillDisappear:(BOOL)animated {
}


// Dissmiss the keyboard on tableView touches by making
// the view the first responder
- (void)didTouchView {
    [self.tableView becomeFirstResponder];
}

- (IBAction)btnAprroveClicked:(id)sender {
    [self didTouchView];
    if ([_txtApproveCode.text length] == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Bạn chưa nhập mã xác nhận" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    NSMutableString *strBuilder = [[NSMutableString alloc] init];
    for (Account *a in _transactionService.accounts) {
        if (a.available < 0) {
            [[[UIAlertView alloc] initWithTitle:@"KHÔNG ĐỦ SỐ DƯ" message:@"Bạn phải hủy bỏ một số giao dịch" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            return;
        }
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:a.transfers];
        [array addObjectsFromArray:a.batchs];
        [array addObjectsFromArray:a.others];
        for (Transaction *t in array) {
            if(t.checked) [strBuilder appendFormat:@"%@|",t.tranSn];
        }
        
    }
    if ([strBuilder length] == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Bạn phải chọn ít nhất 1 giao dịch" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    [strBuilder deleteCharactersInRange:NSMakeRange([strBuilder length] - 1, 1)];
    [_transactionApproveService approveCode:_txtApproveCode.text transactions:strBuilder];
    _txtApproveCode.text = @"";
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
       
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
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
    [super startRequest:service];
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
    
    if (service == _transactionApproveService) {
        if([_transactionApproveService parser:data context:nil]) {
            TransactionResultViewController *resultViewController = [[TransactionResultViewController alloc] init];
            resultViewController.listFaild = _transactionApproveService.listFaild;
            resultViewController.listSucc = _transactionApproveService.listSucc;
            [self pushViewController:resultViewController animated:YES title:NSLocalizedString(@"Result", @"")];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Mã xác nhận không đúng" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        
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
    
    [super finishRequest:service];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self didTouchView];
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

- (void)didOutOfMoney{
    [[[UIAlertView alloc] initWithTitle:@"KHÔNG ĐỦ SỐ DƯ" message:@"Bạn phải hủy bỏ một số giao dịch" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
@end
