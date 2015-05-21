//
//  Transaction.m
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "Transaction.h"
#import "Benefit.h"
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
    if ([arr count] > 0) {
        [(Transaction *)[arr objectAtIndex:0] setIsShowTitle:YES];
    }
    return arr;
}

+ (NSMutableArray *)mixArray:(NSArray *)array items:(NSArray *)oldItems context:(NSManagedObjectContext *)context {
    if (array == nil) {
        return nil;
    }
    if (oldItems == nil) {
        if ([array count] > 0) {
            [(Transaction *)[array objectAtIndex:0] setIsShowTitle:YES];
        }
        return [[NSMutableArray alloc] initWithArray:array];
    }
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableArray *arrOld = [[NSMutableArray alloc] initWithArray:oldItems];
    for (Transaction *t in array) {
        bool found = NO;
        for (Transaction *oldTrans in arrOld) {
            oldTrans.isShowTitle = NO;// reset show title flag
            if ([oldTrans loadFromItem:t context:context]) {
                if (oldTrans.amount == 0) {
                    [arrOld removeObject:oldTrans];
                }
                found = YES;
                break;
            }
        }
        if (found == NO) {
            [arr addObject:t];
        }
    }
    [arr addObjectsFromArray:arrOld];
    if ([arr count] > 0) {
        [(Transaction *)[arr objectAtIndex:0] setIsShowTitle:YES];
    }
    return arr;
    
}
- (BOOL)loadFromItem:(Transaction *)transactionNew context:(NSManagedObjectContext *)context
{
    if ([transactionNew.tranSn isEqualToString:_tranSn]) {
        if ([@"" isEqualToString:transactionNew.createBy]) {
            _info1 = transactionNew.info1;
            _info2 = transactionNew.info2;
            _amount = transactionNew.amount;
            _isDetail = NO;
            _expand = NO;
        } else {
            _createBy = transactionNew.createBy;
            _createTime = transactionNew.createTime;
            _interestAccount = transactionNew.interestAccount;
            _interestAmount = transactionNew.interestAmount;
            _interestRate = transactionNew.interestRate;
            _term = transactionNew.term;
            _type = transactionNew.type;
            _benefits = transactionNew.benefits;
            _isDetail = YES;
            _expand = YES;
        }
 
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
    transaction.benefits = [Benefit arrayFromArrayDictionary:[dictionary arrayForKey:@"benefits"] context:context];
    transaction.createBy = [dictionary stringForKey:@"createBy"];
    transaction.createTime = [dictionary stringForKey:@"createTime"];
    transaction.interestAccount = [dictionary stringForKey:@"interestAccount"];
    transaction.interestAmount = [dictionary doubleForKey:@"interestAmount"];
    transaction.interestRate = [dictionary doubleForKey:@"interestRate"];
    transaction.term = [dictionary stringForKey:@"term"];
    transaction.type = [dictionary intForKey:@"type"];
    transaction.message = [dictionary stringForKey:@"message"];
    transaction.sourceAcc = [dictionary stringForKey:@"sourceAcc"];
    transaction.info = [dictionary stringForKey:@"info"];
    transaction.benefit = [dictionary stringForKey:@"benefit"];
    transaction.transType = [dictionary intForKey:@"transType"];
    transaction.userId = [dictionary intForKey:@"userId"];
    transaction.approveTime = [dictionary stringForKey:@"approveTime"];
    
    // Check is detail then no need convert from info1 to type
    transaction.isDetail = NO;
    if (transaction.createBy || [@"" isEqualToString:transaction.createBy]) {
        transaction.isDetail = YES;
        return transaction;
    }
    return transaction;
}
@end
