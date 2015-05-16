//
//  TransactionTableViewCell.m
//  IB Checker
//
//  Created by Thanh on 5/16/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "TransactionTableViewCell.h"
#import "Transaction.h"

@implementation TransactionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)cellWithData:(Transaction *) trasaction {
    _transaction = trasaction;

    _lbInfo2.text = trasaction.info2;
    switch (trasaction.type) {
        case TransactionTypeInternalTransfer:
            _lbInfo1.text = NSLocalizedString(@"Internal tranfer", @"");
            _lbTitle.text = NSLocalizedString(@"Transfers", @"");
            break;
        case TransactionTypeInterBankTransfer:
            _lbInfo1.text = NSLocalizedString(@"Inter-bank tranfer", @"");
            _lbTitle.text = NSLocalizedString(@"Transfers", @"");
            break;
        case TransactionTypeBatch:
            _lbInfo1.text = trasaction.info2;
            _lbInfo2.text = @"";
            _lbTitle.text = NSLocalizedString(@"Batchs", @"");
            break;
        case TransactionTypeSaving:
            _lbInfo1.text = NSLocalizedString(@"Open saving account", @"");
            _lbTitle.text = NSLocalizedString(@"Others", @"");
            break;
        case TransactionTypeSettlement:
            _lbInfo1.text = NSLocalizedString(@"Settlement", @"");
            _lbTitle.text = NSLocalizedString(@"Others", @"");
            break;
            
        default:
            break;
    }

    _btnCheck.selected = trasaction.checked;
    _btnExpand.selected = trasaction.expand;
    if(_btnExpand.selected) {
        // Bind detail view
        
    }
}

- (IBAction)btnCheckChangeValue:(UIButton *)button {
    button.selected = !button.selected;
    _transaction.checked = button.selected;
}

- (IBAction)btnExpandChangeValue:(UIButton *)button {

    if (_transaction.isDetail) { //Check exist data
        button.selected = !button.selected;
        _transaction.expand = button.selected;
    } else {
        // Request details data
        if (_delegate) {
            [_delegate requestDetail:self transaction:_transaction];
        }
    }
    
}


+ (CGFloat)heightForCellWithData:(Transaction *)transaction
{
    float height = 45.0f;
    if (transaction.expand) {
        // Full height
        
    }
    
    // Normal height
    return height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
