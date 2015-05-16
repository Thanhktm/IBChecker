//
//  Account.m
//  IB Checker
//
//  Created by Thanh on 5/15/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "Account.h"
#import "Transaction.h"

@implementation Account
//@dynamic sourceAccout;
//@dynamic availbleBalance;
//@dynamic currencyCode;
//@dynamic transfers;
//@dynamic batchs;
//@dynamic others;

+ (Account *)create: (NSManagedObjectContext *) context {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:context];
}

+ (NSArray *)arrayFromArrayDictionary:(NSArray *)array context:(NSManagedObjectContext *)context
{
    if (array == nil) {
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        [arr addObject:[Account objectFromDictionary:dict context:context]];
    }
    return arr;
}

+ (NSArray *)mixArray:(NSArray *)array items:(NSArray *)oldItems context:(NSManagedObjectContext *)context
{
    if (array == nil || oldItems == nil) {
        return nil;
    }
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (Account *a in array) {
        bool found = NO;
        for (Account *oldAccount in oldItems) {
            if ([oldAccount loadFromItem:a context:context]) {
                found = YES;
                break;
            }
        }
        if (found == NO) {
            [arr addObject:a];
        }
    }
    [arr addObjectsFromArray:oldItems];
    return arr;
    
}

- (BOOL)loadFromItem:(Account *)accountNew context:(NSManagedObjectContext *)context {

    if ([_sourceAccout isEqualToString:accountNew.sourceAccout]) {
        _availbleBalance = accountNew.availbleBalance;
        _currencyCode = accountNew.currencyCode;
        if (_transfers) {
            _transfers = [Transaction mixArray:accountNew.transfers items:_transfers context:context];
        } else {
            _transfers = accountNew.transfers;
        }
        
        if (_batchs) {
            _batchs = [Transaction mixArray:accountNew.batchs items:_batchs context:context];
        } else {
            _batchs = accountNew.batchs;
        }
        
        if (_others) {
            _others = [Transaction mixArray:accountNew.others items:_others context:context];
        } else {
            _others = accountNew.others;
        }
        return YES;
    }
    return NO;
    
}

+ (id)objectFromDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context
{
    Account *account = nil;
    if (context) {
        account = [Account create:context];
    } else  {
        account = [[Account alloc] init];
    }
    
    account.sourceAccout = [dictionary stringForKey:@"sourceAccout"];
    account.availbleBalance = [dictionary doubleForKey:@"availbleBalance"];
    account.currencyCode = [dictionary stringForKey:@"currencyCode"];
    account.transfers = [[NSMutableArray alloc] initWithArray:[Transaction arrayFromArrayDictionary:[dictionary arrayForKey:@"transfers"] context:context]];
    account.batchs = [[NSMutableArray alloc] initWithArray:[Transaction arrayFromArrayDictionary:[dictionary arrayForKey:@"batchs"] context:context]];
    account.others = [[NSMutableArray alloc] initWithArray:[Transaction arrayFromArrayDictionary:[dictionary arrayForKey:@"others"] context:context]];
    return account;
}
@end
