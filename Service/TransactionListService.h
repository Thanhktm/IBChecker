//
//  TransactionListService.h
//  IB Checker
//
//  Created by Thanh on 5/20/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseService.h"

@interface TransactionListService : BaseService
@property (nonatomic, strong) NSMutableArray *transactions;

- (void)getListAllPage:(int)page;

- (void)getListFailPage:(int)page;

- (void)getListSuccessPage:(int)page;
@end
