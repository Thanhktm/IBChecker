//
//  TransactionApprove.m
//  IB Checker
//
//  Created by Thanh on 5/18/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "TransactionApprove.h"
#import "Transaction.h"

@implementation TransactionApprove
- (void) approveCode:(NSString *)code transactions:(NSString *)tranSn {
    NSDictionary *parmas = @{@"tranSn":tranSn,@"passCode":@"96e79218965eb72c92a549dd5a330112"};
    [self post:@"approve" params:parmas];
}

- (BOOL)parser:(NSDictionary *)data context:(NSManagedObjectContext *)context {
    _listFaild = [Transaction arrayFromArrayDictionary:[data arrayForKey:@"listFail"] context:context];
    _listSucc = [Transaction arrayFromArrayDictionary:[data arrayForKey:@"listSucc"] context:context];
    return YES;
}
@end
