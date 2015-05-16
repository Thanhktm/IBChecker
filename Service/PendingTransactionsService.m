//
//  PendingTransactionsService.m
//  IB Checker
//
//  Created by Thanh on 5/12/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "PendingTransactionsService.h"
#import "Account.h"

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
    return YES;
}
@end
