//
//  Account.h
//  IB Checker
//
//  Created by Thanh on 5/15/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "Item.h"

@interface Account : Item <NSCopying>
@property (nonatomic, retain) NSString * sourceAccout;
@property (nonatomic) double availbleBalance;
@property (nonatomic, retain) NSString * currencyCode;
@property (nonatomic, retain) NSMutableArray * transfers;
@property (nonatomic, retain) NSMutableArray * batchs;
@property (nonatomic, retain) NSMutableArray * others;
@property (nonatomic) BOOL checked;
@property (nonatomic) double available;
@end
