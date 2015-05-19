//
//  TransactionResultViewController.h
//  IB Checker
//
//  Created by Thanh on 5/19/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseViewController.h"

@interface TransactionResultViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray * listFaild;
@property (nonatomic, strong) NSArray * listSucc;

@end
