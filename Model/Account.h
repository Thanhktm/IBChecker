//
//  Account.h
//  IB Checker
//
//  Created by Thanh on 5/15/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "Item.h"

@interface Account : Item
@property (nonatomic, retain) NSString * sourceAccout;
@property (nonatomic) double availbleBalance;
@property (nonatomic, retain) NSString * currencyCode;
@property (nonatomic, retain) NSArray * transfers;
@property (nonatomic, retain) NSArray * batchs;
@property (nonatomic, retain) NSArray * others;
@property (nonatomic) BOOL checked;

@end
