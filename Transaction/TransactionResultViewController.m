//
//  TransactionResultViewController.m
//  IB Checker
//
//  Created by Thanh on 5/19/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "TransactionResultViewController.h"
#import "TransactionResultCell.h"
#import "TransactionResultHeaderView.h"

@interface TransactionResultViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TransactionResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setTitle:NSLocalizedString(@"Result", @"")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marl TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int numberSection = 0 ;
    if ([_listFaild count] > 0) numberSection ++;
    if ([_listSucc count] > 0) numberSection++;
    return numberSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && [_listFaild count] > 0) {
        return [_listFaild count];
    }
    
    if ((section == 0 && [_listFaild count] == 0) || section == 1) {
        return [_listSucc count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Transaction *transaction = nil;
    if ([_listFaild count] > 0 && indexPath.section == 0) {
        transaction = [_listFaild objectAtIndex:indexPath.row];
    }
    
    if ((indexPath.section == 0 && [_listFaild count] == 0) || indexPath.section == 1) {
        transaction = [_listSucc objectAtIndex:indexPath.row];
    }
    
    return [TransactionResultCell heightForCellWithData:transaction];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TransactionResultHeaderView *header = [tableView dequeueReusableCellWithIdentifier:@"header"];
    if (header == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"TransactionResultHeaderView" bundle:nil] forCellReuseIdentifier:@"header"];
        header = [tableView dequeueReusableCellWithIdentifier:@"header"];
    }
    if ([_listFaild count] > 0 && section == 0) {
        [header cellWithData:[_listFaild count] total:([_listFaild count] + [_listSucc count]) status:NO];
    }
    if ((section == 0 && [_listFaild count] == 0) || section == 1) {
        [header cellWithData:[_listSucc count] total:([_listFaild count] + [_listSucc count]) status:YES];
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"TransactionResultCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
    }
    
    Transaction *transaction = nil;
    if ([_listFaild count] > 0 && indexPath.section == 0) {
        transaction = [_listFaild objectAtIndex:indexPath.row];
    }
    
    if ((indexPath.section == 0 && [_listFaild count] == 0) || indexPath.section == 1) {
        transaction = [_listSucc objectAtIndex:indexPath.row];
    }
    
    [cell cellWithData:transaction];
    
    return cell;
    
}

@end
