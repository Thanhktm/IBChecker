//
//  TransactionResultCell.m
//  IB Checker
//
//  Created by Thanh on 5/19/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "TransactionResultCell.h"
#import "Transaction.h"

@implementation TransactionResultCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)cellWithData:(Transaction *)transaction{
    _transaction = transaction;
    _lbInfo.text = transaction.info;

    _lbTransactionLine.text = [NSString stringWithFormat:@"*%@ %@ %@",[transaction.sourceAcc substringFromIndex:([transaction.sourceAcc length] - 4)], NSLocalizedString(@"to", @""), transaction.benefit];
    _lbMessage.text = transaction.message;
    _lbAmout.text = [Transaction formatNumber:transaction.amount];
    
    // Not set currnency yet
//    _lbCurrencyCode.text = ????
    
    [self setNeedsDisplay];
}

+ (CGFloat)heightForCellWithData:(Transaction *)transaction
{
    return 50.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
