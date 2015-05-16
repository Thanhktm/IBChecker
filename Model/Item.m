//
//  Item.m
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "Item.h"

@implementation Item

- (BOOL)loadFromItem:(Item *)item context:(NSManagedObjectContext *)context
{
    return YES;
}

+ (NSArray *)mixArray:(NSArray *)array items:(NSArray *)items context:(NSManagedObjectContext *)context {
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
