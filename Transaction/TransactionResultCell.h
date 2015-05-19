//
//  TransactionResultCell.h
//  IB Checker
//
//  Created by Thanh on 5/19/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Transaction;

@interface TransactionResultCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbAmout;
@property (strong, nonatomic) IBOutlet UILabel *lbInfo;
@property (strong, nonatomic) IBOutlet UILabel *lbTransactionLine;
@property (strong, nonatomic) IBOutlet UILabel *lbMessage;
@property (strong, nonatomic) IBOutlet UILabel *lbCurrencyCode;

@property (nonatomic, strong) Transaction *transaction;

- (void)cellWithData:(Transaction *)transaction;
+ (CGFloat)heightForCellWithData:(Transaction *)transaction;
@end
