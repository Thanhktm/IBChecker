//
//  Benifit.h
//  IB Checker
//
//  Created by Thanh on 5/16/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "Item.h"

@interface Benefit : Item

@property (nonatomic, retain) NSString * accountNo;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * bank;
@property (nonatomic) double amount;
@property (nonatomic, retain) NSString * currencyCode;
@end
