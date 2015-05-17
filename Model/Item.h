//
//  Item.h
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+Extra.h"
#import <CoreData/CoreData.h>

@interface Item : NSObject

@property (nonatomic) NSInteger itemId;
@property (nonatomic, retain) NSString *itemName;
+ (NSString *)formatNumber:(double) number;
+ (NSString *)formatPercent:(double)number;

- (BOOL)loadFromItem:(Item *)item context:(NSManagedObjectContext *)context;

+ (NSArray *)arrayFromArrayDictionary:(NSArray *)array context:(NSManagedObjectContext *)context;

+ (NSMutableArray *)mixArray:(NSArray *)array items:(NSArray *)items context:(NSManagedObjectContext *)context;

+ (id)objectFromDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context;

@end
