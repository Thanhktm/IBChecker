//
//  HistoryViewController.m
//  IB Checker
//
//  Created by Thanh on 5/20/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "HistoryViewController.h"
#import "User.h"
#import "TransactionListService.h"
#import "Transaction.h"
#import "HistoryTableViewCell.h"

@interface HistoryViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) TransactionListService * listAllService;
@property (nonatomic, strong) TransactionListService * listFailService;
@property (nonatomic, strong) TransactionListService * listSuccessService;
@property (nonatomic) int mode;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) int pageAll;
@property (nonatomic) int pageFail;
@property (nonatomic) int pageSuccess;
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _listAllService = [[TransactionListService alloc] initWithDelegate:self authtoken:self.user.authtoken];
    
    _listFailService = [[TransactionListService alloc] initWithDelegate:self authtoken:self.user.authtoken];
    
    _listSuccessService = [[TransactionListService alloc] initWithDelegate:self authtoken:self.user.authtoken];
    
    _pageAll = 1;
    _pageFail = 1;
    _pageSuccess = 1;
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:_refreshControl];
    
    [_listAllService getListAllPage:_pageAll];
    _tableView.tableHeaderView = _headerView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setTitle:NSLocalizedString(@"history", @"")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}


#pragma mark refresh control
- (void)refresh:(UIRefreshControl *)refreshControl {
    switch (_segment.selectedSegmentIndex) {
        case 0:
            _pageAll++;
            [_listAllService getListAllPage:_pageAll];
            break;
        case 1:
            _pageSuccess++;
           [_listSuccessService getListSuccessPage:_pageSuccess];
            break;
        case 2:
            _pageFail++;
            [_listFailService getListFailPage:_pageFail];
            break;
        default:
            break;
    }

}

- (IBAction)segmentChange:(UISegmentedControl *)segmentControl {
    switch (segmentControl.selectedSegmentIndex) {
        case 0:
            if (!_listAllService.transactions) {
                [_listAllService getListAllPage:_pageAll];
            }
            break;
        case 1:
            if (!_listSuccessService.transactions) {
                [_listSuccessService getListSuccessPage:_pageSuccess];
            }
            break;
        case 2:
            if (!_listFailService.transactions) {
                [_listFailService getListFailPage:_pageFail];
            }
            break;
        default:
            return;
        break;
    }
    [_tableView reloadData];
    
}

#pragma mark service
- (void)startRequest:(BaseService *)service {
    [_segment setEnabled:NO];
    [super startRequest:service];

}

- (void)successRequest:(BaseService *)service response:(NSDictionary *)data {
    if (service == _listAllService && [_listAllService parser:data context:nil]) {
        
    }
    
    if (service == _listSuccessService && [_listSuccessService parser:data context:nil]) {
        
    }
    
    if (service == _listFailService && [_listFailService parser:data context:nil]) {
        
    }
    
    [_tableView reloadData];
    [super successRequest:service response:data];
}


- (void)finishRequest:(BaseService *)service {
    [_refreshControl endRefreshing];
    [_segment setEnabled:YES];
    [super finishRequest:service];
}


#pragma mark tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (_segment.selectedSegmentIndex) {
        case 0:
            return [_listAllService.transactions count];
            break;
        case 1:
            return [_listSuccessService.transactions count];
            break;
        case 2:
            return  [_listFailService.transactions count];
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
    }
    Transaction *transaction;
    switch (_segment.selectedSegmentIndex) {
        case 0:
            transaction = [_listAllService.transactions objectAtIndex:indexPath.row];
            break;
        case 1:
            transaction = [_listSuccessService.transactions objectAtIndex:indexPath.row];
            break;
        case 2:
            transaction = [_listFailService.transactions objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    [cell cellWithData:transaction];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
