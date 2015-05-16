//
//  TransactionTableViewCell.h
//  IB Checker
//
//  Created by Thanh on 5/16/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Transaction;
@class TransactionTableViewCell;

@protocol TransactionCellDelegate <NSObject>

- (void)requestDetail:(TransactionTableViewCell *)cell transaction:(Transaction *)transaction;

@end
@interface TransactionTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnCheck;
@property (strong, nonatomic) IBOutlet UILabel *lbInfo1;
@property (strong, nonatomic) IBOutlet UILabel *lbInfo2;
@property (strong, nonatomic) IBOutlet UILabel *lbAmount;
@property (strong, nonatomic) IBOutlet UILabel *lbCurrency;
@property (strong, nonatomic) IBOutlet UIButton *btnExpand;


@property (strong, nonatomic) Transaction * transaction;
@property (strong) id<TransactionCellDelegate> delegate;


- (void)cellWithData:(Transaction *) trasaction;
+ (CGFloat)heightForCellWithData:(Transaction *)transaction;

@end
