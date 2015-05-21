//
//  TransactionListService.m
//  IB Checker
//
//  Created by Thanh on 5/20/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "TransactionListService.h"
#import "Transaction.h"

@implementation TransactionListService
- (void)getListAllPage:(int)page {
    [self getListStatus:0 page:page];
}

- (void)getListFailPage:(int)page {
    [self getListStatus:-1 page:page];
}
- (void)getListSuccessPage:(int)page {
     [self getListStatus:1 page:page];
}

- (void)getListStatus:(int)status page:(int)page {
    if (page == 1) {
        _transactions = nil;
    }
    NSDictionary *params = @{@"pageNo":[NSString stringWithFormat:@"%d", page], @"status": [NSString stringWithFormat:@"%d", status]};
    [self post:@"/getTransactionList" params:params];
}

- (BOOL)parser:(NSDictionary *)data context:(NSManagedObjectContext *)context {
    if (![data valueForKey:@"content"]) {
        return NO;
    }
    if (_transactions == nil) {
        _transactions = [[NSMutableArray alloc] initWithArray:[Transaction arrayFromArrayDictionary:[data arrayForKey:@"content"] context:context]];
    } else {
        NSArray *newArray = [[NSMutableArray alloc] initWithArray:[Transaction arrayFromArrayDictionary:[data arrayForKey:@"content"] context:context]];
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                               NSMakeRange(0,[newArray count])];
        [_transactions insertObjects:newArray atIndexes:indexes];
    }
    return YES;
}
@end
