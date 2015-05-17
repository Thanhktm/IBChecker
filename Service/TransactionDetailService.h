//
//  TransactionDetailService.h
//  IB Checker
//
//  Created by Thanh on 5/17/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseService.h"
@class Transaction;

@interface TransactionDetailService : BaseService
@property (nonatomic, strong) Transaction * transaction;

- (void)getDetailTransaction:(Transaction *)transaction approved:(NSString *)approved;
@end
