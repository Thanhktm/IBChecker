//
//  TransactionDetailViewController.h
//  IB Checker
//
//  Created by Thanh on 5/25/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseViewController.h"

@class Transaction;

@interface TransactionDetailViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) Transaction * transaction;
@end
