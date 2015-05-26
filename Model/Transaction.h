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


typedef enum {
    TransactionFail,
    TransactionSuccess
}TransactionStatus;

@interface Transaction : Item <NSCopying>
@property (nonatomic, strong) NSString * tranSn;
@property (nonatomic, retain) NSString * info1;
@property (nonatomic, retain) NSString * info2;
@property (nonatomic, retain) NSString * currencyCode;
@property (nonatomic) double amount;
@property (nonatomic, retain) NSArray * benefits;
@property (nonatomic, retain) NSString * createBy;
@property (nonatomic, retain) NSString * createTime;
@property (nonatomic, retain) NSString * interestAccount;
@property (nonatomic) double  interestAmount;
@property (nonatomic) double interestRate;
@property (nonatomic, retain) NSString * term;

@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * benefit;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * sourceAcc;
@property (nonatomic) int type;


@property (nonatomic) int transType;
@property (nonatomic) int userId;
@property (nonatomic, retain) NSString * approveTime;
@property (nonatomic, retain) NSString * searchContent;
@property (nonatomic) int status;

// Additional properties for UI
@property (nonatomic) BOOL checked;
@property (nonatomic) BOOL expand;
@property (nonatomic) BOOL isDetail;
@property (nonatomic) BOOL isShowTitle;
@end
