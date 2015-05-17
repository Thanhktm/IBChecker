//
//  Item.m
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "Item.h"

@implementation Item

+ (NSString *)formatNumber:(double) number {

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setUsesGroupingSeparator:YES];
    return [formatter stringFromNumber:[NSNumber numberWithDouble:number]];
}


+ (NSString *)formatPercent:(double)number {
    
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
//    [formatter setGroupingSeparator:@","];
//    [formatter setAlwaysShowsDecimalSeparator:NO];
//    [formatter setUsesGroupingSeparator:YES];
//    return [formatter stringFromNumber:[NSNumber numberWithDouble:number]];
    
    return  [NSString stringWithFormat:@"%.3F%%", number];
}
- (BOOL)loadFromItem:(Item *)item context:(NSManagedObjectContext *)context
{
    return YES;
}

+ (NSMutableArray *)mixArray:(NSArray *)array items:(NSArray *)items context:(NSManagedObjectContext *)context {
    return nil;
}
+ (NSArray *)arrayFromArrayDictionary:(NSArray *)array context:(NSManagedObjectContext *)context
{
    return nil;
}

+ (id)objectFromDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context
{
    return nil;
}
@end
