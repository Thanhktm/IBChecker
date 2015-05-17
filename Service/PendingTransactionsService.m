//
//  PendingTransactionsService.m
//  IB Checker
//
//  Created by Thanh on 5/12/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "PendingTransactionsService.h"
#import "Account.h"
#import "Transaction.h"

@implementation PendingTransactionsService

- (void)getTransactionsPage:(int)page {
    NSDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", page], @"pageNo", nil];
    [self post:@"requestPending" params:params];
}

- (BOOL)parser:(NSDictionary *)data context:(NSManagedObjectContext *)context
{
    if(_accounts == nil) {
        // Page 1
        _accounts = [[NSMutableArray alloc] initWithArray:[Account arrayFromArrayDictionary:[data arrayForKey:@"content"] context:context]];
    } else {
        // Mix data
        _accounts = [Account mixArray:[Account arrayFromArrayDictionary:[data arrayForKey:@"content"] context:context] items:_accounts context:context];
    }
    for (Account *a in _accounts) {
        if ([@"000" isEqualToString:a.currencyCode]) {
            [_accounts removeObject:a];
        } else {
            if (a.transfers) {
                for (Transaction *t in a.transfers) {
                    if (t.amount == 0) {
                        [a.transfers removeObject:t];
                    }
                }
            }
            if (a.batchs) {
                for (Transaction *t in a.batchs) {
                    if (t.amount == 0) {
                        [a.batchs removeObject:t];
                    }
                }
            }
            if (a.others) {
                for (Transaction *t in a.others) {
                    if (t.amount == 0) {
                        [a.others removeObject:t];
                    }
                }
            }
        }
    }
    return YES;
}
@end
