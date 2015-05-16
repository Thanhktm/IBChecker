//
//  PendingTransactionsService.h
//  IB Checker
//
//  Created by Thanh on 5/12/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseService.h"
@interface PendingTransactionsService : BaseService
@property (nonatomic, strong) NSArray * accounts;
- (void)getTransactionsPage:(int)page;
@end
