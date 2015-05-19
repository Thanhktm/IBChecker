//
//  TransactionApprove.h
//  IB Checker
//
//  Created by Thanh on 5/18/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseService.h"

@interface TransactionApprove : BaseService
@property (nonatomic, strong) NSArray *listFaild;
@property (nonatomic, strong) NSArray *listSucc;

- (void) approveCode:(NSString *)code transactions:(NSString *)tranSn;
@end
