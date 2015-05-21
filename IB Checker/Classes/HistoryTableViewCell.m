//
//  HistoryTableViewCell.m
//  IB Checker
//
//  Created by Thanh on 5/20/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "Transaction.h"

@implementation HistoryTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)cellWithData:(Transaction *)transaction {
    _transaction = transaction;
    
    _lbAmount.text = [Transaction formatNumber:transaction.amount];
    _lbDate.text = transaction.approveTime;

    _icon.selected = [@"SUCC" isEqualToString:transaction.message];
    
    switch (transaction.type) {
        case TransactionTypeInternalTransfer:
            _lbInfo.text = [NSString stringWithFormat:NSLocalizedString(@"To: %@", @""), transaction.info];
            _lbMessage.text = NSLocalizedString(@"Internal tranfer", @"");
            break;
        case TransactionTypeInterBankTransfer:
            _lbInfo.text = [NSString stringWithFormat:NSLocalizedString(@"To: %@", @""), transaction.info];
            _lbMessage.text = NSLocalizedString(@"Inter-bank tranfer", @"");
            break;
        case TransactionTypeBatch:
            _lbInfo.text = transaction.benefit;
            _lbMessage.text = NSLocalizedString(@"Batchs", @"");
            break;
        case TransactionTypeSaving:
            _lbInfo.text = transaction.benefit;
            _lbMessage.text = NSLocalizedString(@"Open saving account", @"");
            break;
        case TransactionTypeSettlement:
            _lbInfo.text = [NSString stringWithFormat:NSLocalizedString(@"Settlement %@", @""), transaction.benefit];
            _lbMessage.text = NSLocalizedString(@"Settlement", @"");
            break;
            
        default:
            break;
    }

    [self setNeedsDisplay];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
