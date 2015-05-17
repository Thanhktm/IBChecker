//
//  TransactionDetailService.m
//  IB Checker
//
//  Created by Thanh on 5/17/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "TransactionDetailService.h"
#import "Transaction.h"
#import "Benefit.h"

@implementation TransactionDetailService
- (void)getDetailTransaction:(Transaction *)transaction approved:(NSString *)approved {
    _transaction = transaction;
    NSDictionary *params = @{@"tranSn": transaction.tranSn, @"isApproved": approved};
    [self post:@"detail" params:params];
}


- (BOOL)parser:(NSDictionary *)data context:(NSManagedObjectContext *)context
{
    [_transaction loadFromItem:[Transaction objectFromDictionary:data context:context] context:context];
    // Add currencyCode for Benefits
    for (Benefit *b in _transaction.benefits) {
        b.currencyCode = _transaction.currencyCode;
    }
    return YES;
}
@end

