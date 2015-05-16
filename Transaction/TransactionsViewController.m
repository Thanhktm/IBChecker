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
#import "TransactionTableViewCell.h"
#import "TransactionHeaderView.h"

@interface TransactionsViewController ()
@property (strong) AuthService *authService;
@property (strong) PendingTransactionsService *transactionService;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong) User *user;
@end

@implementation TransactionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *userResult = [self fetchEntity:@"User"];
    
    if ([userResult count] > 0) {
        _user = [userResult objectAtIndex:0];
        _transactionService = [[PendingTransactionsService alloc] initWithDelegate:self authtoken:_user.authtoken];
        [_transactionService getTransactionsPage:1];
    } else {
        _authService = [[AuthService alloc] initWithDelegate:self authtoken:nil];
        [_authService login:@"sn_checker" password:@"96e79218965eb72c92a549dd5a330112"];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Service response

- (void)successRequest:(BaseService *)service response:(NSDictionary *)data
{
    if (service == _authService && [_authService parser:data context:self.managedObjectContext]) {
        
    }
    if (service == _transactionService && [_transactionService parser:data context:nil]) {
        NSLog(@"count %d", _transactionService.accounts.count);
        [_tableView reloadData];
    }
    [super successRequest:service response:data];
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
//    Account *account = [_transactionService.accounts objectAtIndex:section];
//    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TransactionsViewController" owner:self options:nil];
//    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
//   TransactionHeaderView *view = [topLevelObjects objectAtIndex:2];
//    [view loadHeaderWithData:account];
    return [[UIView alloc] init];
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
//    TransactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"transaction"];
//    if (cell == nil) {
//        // Load the top-level objects from the custom cell XIB.
//        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TransactionsViewController" owner:self options:nil];
//        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
//        cell = [topLevelObjects objectAtIndex:1];
//    }
//    Account *account = [_transactionService.accounts objectAtIndex:indexPath.section];
//    Transaction *transaction = nil;
//    
//    if (indexPath.row < account.transfers.count) {
//        transaction = [account.transfers objectAtIndex:indexPath.row];
//    } else if (indexPath.row >= account.transfers.count && indexPath.row < (account.transfers.count + account.batchs.count)) {
//        transaction = [account.batchs objectAtIndex:(indexPath.row - account.transfers.count)];
//    } else {
//        transaction = [account.others objectAtIndex:(indexPath.row - account.transfers.count - account.batchs.count)];
//        
//    }
//    
//    [cell cellWithData:transaction];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"transaction"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"transaction"];
    }
    cell.textLabel.text = @"Thanh";
    return cell;
 }


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
