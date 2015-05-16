//
//  Transaction.h
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "Item.h"
typedef enum {
    TransactionTypeInternalTransfer,
    TransactionTypeInterBankTransfer,
    TransactionTypeBatch,
    TransactionTypeSaving,
    TransactionTypeSettlement
}TransactionType;

@interface Transaction : Item
@property (nonatomic, strong) NSString * tranSn;
@property (nonatomic, retain) NSString * info1;
@property (nonatomic, retain) NSString * info2;
@property (nonatomic) double amount;
@property (nonatomic) BOOL checked;
@property (nonatomic) BOOL expand;
@property (nonatomic) BOOL isDetail;
@property (nonatomic) int type;
@end
