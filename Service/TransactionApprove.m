//
//  TransactionApprove.m
//  IB Checker
//
//  Created by Thanh on 5/18/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "TransactionApprove.h"
#import "Transaction.h"
#import "NSString+MD5.h"

@implementation TransactionApprove
- (void) approveCode:(NSString *)code transactions:(NSString *)tranSn {
    NSDictionary *parmas = @{@"tranSn":tranSn,@"passCode":[code MD5Hash]};
    [self post:@"approve" params:parmas];
}

- (BOOL)parser:(NSDictionary *)data context:(NSManagedObjectContext *)context {
    if ([data valueForKey:@"content"] || ![data arrayForKey:@"listFail"]) {
        return NO;
    }
    _listFaild = [Transaction arrayFromArrayDictionary:[data arrayForKey:@"listFail"] context:context];
    _listSucc = [Transaction arrayFromArrayDictionary:[data arrayForKey:@"listSucc"] context:context];
    return YES;
}
@end
