//
//  TransactionDetailViewController.m
//  IB Checker
//
//  Created by Thanh on 5/25/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "TransactionDetailViewController.h"
#import "Transaction.h"
#import "TransactionApprove.h"
#import "TransactionDetailService.h"
#import "User.h"
#import "BCTableView.h"
#import "BCTextField.h"
#import "DetailTableViewCell.h"
#import "Benefit.h"


@interface TransactionDetailViewController ()

@property (nonatomic, strong) TransactionApprove * approveService;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *lbAmount;
@property (strong, nonatomic) IBOutlet UILabel *lbStatus;
@property (strong, nonatomic) IBOutlet UILabel *lbInfo;

@property (strong, nonatomic) IBOutlet UILabel *lbCurrency;
@property (strong, nonatomic) IBOutlet BCTableView *tableView;
@property (strong, nonatomic) IBOutlet BCTextField *txtApproveCode;
@property (strong, nonatomic) IBOutlet UIButton *btnApprove;
@property (nonatomic, strong) TransactionDetailService * transactionDetailService;
@end

@implementation TransactionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _approveService = [[TransactionApprove alloc] initWithDelegate:self authtoken:self.user.authtoken];
    _transactionDetailService = [[TransactionDetailService alloc] initWithDelegate:self authtoken:self.user.authtoken];
    [_transactionDetailService getDetailTransaction:_transaction approved:@"1"];
    _tableView.tableHeaderView = _headerView;
    _transaction.currencyCode = @"VND";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self bindHeader];
}

- (void) bindHeader{
    _lbAmount.text = [Transaction formatNumber:_transaction.amount];
    CGSize boundingSize = CGSizeMake(135.0, 500.0);
    CGSize requiredSize = [_lbAmount.text sizeWithFont:[UIFont boldSystemFontOfSize:19] constrainedToSize:boundingSize lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect frame = _lbAmount.frame;
    frame.size.width = requiredSize.width;
    frame.size.height = requiredSize.height;
    
    _lbAmount.frame = frame;
    
    CGRect frameCurrentcy = _lbCurrency.frame;
    frameCurrentcy.origin.x = frame.origin.x + frame.size.width + 4;
    _lbCurrency.frame = frameCurrentcy;
    switch (_transaction.type) {
        case TransactionTypeInternalTransfer:
            _lbInfo.text = NSLocalizedString(@"Internal tranfer", @"");
            break;
        case TransactionTypeInterBankTransfer:
            _lbInfo.text = NSLocalizedString(@"Inter-bank tranfer", @"");
            break;
        case TransactionTypeBatch:
            _lbInfo.text = _transaction.info1;
            break;
        case TransactionTypeSaving:
            _lbInfo.text = NSLocalizedString(@"Open saving account", @"");
            break;
        case TransactionTypeSettlement:
            _lbInfo.text = NSLocalizedString(@"Settlement", @"");
            break;
            
        default:
            break;
    }
    
    _lbStatus.text = (_transaction.status == TransactionSuccess ? NSLocalizedString(@"Detail status success", @"") : NSLocalizedString(@"Detail status fail", @""));
    _lbCurrency.text = _transaction.currencyCode;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Service

- (void)startRequest:(BaseService *)service {
    [super startRequest:service];
}

- (void)successRequest:(BaseService *)service response:(NSDictionary *)data {
    if (service == _transactionDetailService && [_transactionDetailService parser:data context:nil]) {
        [_tableView reloadData];
    }
}

- (void)finishRequest:(BaseService *)service {
    [super finishRequest:service];
}

#pragma mark - UITableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 45;
    if (indexPath.row == 2 &&_transaction.type == TransactionTypeInterBankTransfer && [_transaction.benefits count] > 0){
        Benefit *benefit = [_transaction.benefits objectAtIndex:0];
        if (benefit.bank && ![@"" isEqualToString:benefit.bank]) {
            CGSize boundingSize = CGSizeMake(163.0, 500.0);
            CGSize requiredSize = [benefit.bank sizeWithFont:[UIFont systemFontOfSize:14    ] constrainedToSize:boundingSize lineBreakMode:NSLineBreakByWordWrapping];
            
            height += requiredSize.height - 5;
        }
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_transaction.type) {
        case TransactionTypeInterBankTransfer:
        case TransactionTypeInternalTransfer:
        case TransactionTypeBatch:
        case TransactionTypeSaving:
            return 3;
            break;
        case TransactionTypeSettlement:
            return 5;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
    }

    NSString *title = @"";
    NSString *content = @"";
    
    
    if (indexPath.row == 0) {
        title = NSLocalizedString(@"Created date", @"");
        content = _transaction.createTime;
        
    } else if (indexPath.row == 1) {
        title = NSLocalizedString(@"Created by", @"");
        content = _transaction.createBy;
    } else {
        switch (_transaction.type) {
            case TransactionTypeInterBankTransfer:
                case TransactionTypeBatch:
                case TransactionTypeInternalTransfer:
                NSLog(@"index: %d", indexPath.row);
                if (indexPath.row == 2 && [_transaction.benefits count] > 0) {
                    Benefit *benefit = [_transaction.benefits objectAtIndex:0];
                    title = NSLocalizedString(@"Target account", @"");
                    content = benefit.accountNo;
                    if (benefit.bank && ![@"" isEqualToString:benefit.bank]) {
                        CGSize boundingSize = CGSizeMake(163.0, 500.0);
                        CGSize requiredSize = [benefit.bank sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:boundingSize lineBreakMode:NSLineBreakByWordWrapping];
                        
                        CGRect frame = cell.lbDescription.frame;
                        frame.origin.y = 35;
                        frame.size.height = requiredSize.height;
                        cell.lbDescription.frame = frame;
                        cell.lbDescription.text = benefit.bank;
                    }
                }
            break;
            case TransactionTypeSaving:
                if (indexPath.row == 2) {
                    title = NSLocalizedString(@"Saving acocunt", @"");
                    content = _transaction.interestAccount ? _transaction.interestAccount : NSLocalizedString(@"Accumulated principal", @"");
                }
                break;
            case TransactionTypeSettlement:
                if (indexPath.row == 2) {
                    title = NSLocalizedString(@"Term", @"");
                    content = _transaction.term;
                } else if (indexPath.row == 3) {
                    title = NSLocalizedString(@"Interest rate", @"");
                    content = [Transaction formatPercent:_transaction.interestRate];
                } else if (indexPath.row == 4) {
                    title = NSLocalizedString(@"Interest amount", @"");
                    content = [NSString stringWithFormat:@"%@ %@",[Transaction formatNumber:_transaction.interestAmount],_transaction.currencyCode];
                }
                break;
            default:
                break;
                
        }
    }
    
    cell.lbTitle.text = title;
    cell.lbContent.text = content;
    return cell;

}

@end
