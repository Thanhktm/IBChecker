//
//  PendingTransactionsService.h
//  IB Checker
//
//  Created by Thanh on 5/12/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseService.h"
@interface PendingTransactionsService : BaseService
@property (nonatomic, strong) NSMutableArray * accounts;
@property (nonatomic, strong) NSMutableArray * accountsBase;
@property (nonatomic, strong) NSMutableArray * accountsSearch;
- (void)getTransactionsPage:(int)page;
@end
