//
//  Transaction.m
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction
//@dynamic tranSn;
//@dynamic info1;
//@dynamic info2;
//@dynamic amount;

+ (Transaction *) create: (NSManagedObjectContext *) context {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];
}

+ (NSArray *)arrayFromArrayDictionary:(NSArray *)array context:(NSManagedObjectContext *)context
{
    if (!array) {
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        [arr addObject:[Transaction objectFromDictionary:dict context:context]];
    }
    return arr;
}

+ (NSArray *)mixArray:(NSArray *)array items:(NSArray *)oldItems context:(NSManagedObjectContext *)context {
    if (array == nil || oldItems == nil) {
        return nil;
    }
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (Transaction *t in array) {
        bool found = NO;
        for (Transaction *oldTrans in oldItems) {
            if ([oldTrans loadFromItem:t context:context]) {
                found = YES;
                break;
            }
        }
        if (found == NO) {
            [arr addObject:t];
        }
    }
    [arr addObjectsFromArray:oldItems];
    return arr;
    
}
- (BOOL)loadFromItem:(Transaction *)transactionNew context:(NSManagedObjectContext *)context
{
    if ([transactionNew.tranSn isEqualToString:_tranSn]) {
        _info1 = transactionNew.info1;
        _info2 = transactionNew.info2;
        _amount = transactionNew.amount;
        return YES;
    }
    return NO;
}

+ (id)objectFromDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context
{
    Transaction * transaction = nil;
    if (!context) {
        transaction = [[Transaction alloc] init];
    } else {
        transaction = [Transaction create:context];
    }
    transaction.tranSn = [dictionary stringForKey:@"tranSn"];
    transaction.info1 = [dictionary stringForKey:@"info1"];
    transaction.info2 = [dictionary stringForKey:@"info2"];
    transaction.amount = [dictionary doubleForKey:@"amount"];
    transaction.type = TransactionTypeBatch;
    if ([@"N" isEqualToString:transaction.info1]) {
        transaction.type = TransactionTypeInternalTransfer;
    }
    if ([@"Y" isEqualToString:transaction.info1]) {
        transaction.type = TransactionTypeInterBankTransfer;
    }
    if ([@"OPEN" isEqualToString:transaction.info1]) {
        transaction.type = TransactionTypeSaving;
    }
    if ([@"SETTELEMENT" isEqualToString:transaction.info1]) {
        transaction.type = TransactionTypeSettlement;
    }
    return transaction;
}
@end
