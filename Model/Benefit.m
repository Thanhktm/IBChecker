//
//  Benifit.m
//  IB Checker
//
//  Created by Thanh on 5/16/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "Benefit.h"

@implementation Benefit
+ (id)objectFromDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context
{
    Benefit *benifit = [[Benefit alloc] init];
    benifit.accountNo = [dictionary stringForKey:@"accountNo"];
    benifit.name = [dictionary stringForKey:@"name"];
    benifit.bank = [dictionary stringForKey:@"bank"];
    benifit.amount = [dictionary doubleForKey:@"amount"];
    return benifit;
}

+ (NSArray *)arrayFromArrayDictionary:(NSArray *)array context:(NSManagedObjectContext *)context {
    if (array == nil) {
        return nil;
    }
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        [arr addObject:[Benefit objectFromDictionary:dict context:context]];
    }
    return arr;
}
@end
