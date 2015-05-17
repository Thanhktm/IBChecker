//
//  TransactionHeaderView.m
//  IB Checker
//
//  Created by Thanh on 5/16/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "TransactionHeaderView.h"
#import "Account.h"
#import "Transaction.h"

@implementation TransactionHeaderView

- (void)layoutSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)cellWithData:(Account *) account
{
    _account = account;
    _lbSourceAccount.text = [NSString stringWithFormat:@"Tài khoản nguồn: *%@",[account.sourceAccout substringFromIndex:[account.sourceAccout length] - 4]];
    _lbAvailableBalance.text = [Account formatNumber:account.availbleBalance];

    
    double totalChecked = 0;
    int numberChecked = 0;
    int numberTransaction = 0;
    
    if (account.transfers) {
        for (Transaction *t in account.transfers) {
            numberTransaction++;
            if (t.checked) {
                totalChecked += t.amount;
                numberChecked++;
            }
        }
    }
    
    if (account.batchs) {
        for (Transaction *t in account.batchs) {
            numberTransaction++;
            if (t.checked) {
                totalChecked += t.amount;
                numberChecked++;
            }
        }
    }
    
    if (account.others) {
        for (Transaction *t in account.others) {
            numberTransaction++;
            if (t.checked) {
                if (t.type == TransactionTypeSettlement) {
                    totalChecked -= t.amount;
                } else {
                    totalChecked += t.amount;
                }
                numberChecked++;
            }
        }
    }

    _account.checked  = (numberChecked == numberTransaction);
    _lbAvailableAfter.text = [Account formatNumber:(account.availbleBalance - totalChecked)];
    NSString *string = [NSString stringWithFormat:@"%d của %d món đang chọn", numberChecked, numberTransaction];
    
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:string];
    [attrs addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:[string rangeOfString:[NSString stringWithFormat:@"%d", numberChecked]]];
    [attrs addAttribute:NSForegroundColorAttributeName
                  value:[UIColor redColor]
                  range:[string rangeOfString:[NSString stringWithFormat:@" %d", numberTransaction]]];
    
    [_lblCheckedNumber setAttributedText:attrs];
    _btnCheckAll.selected = account.checked;
    
    [self setNeedsDisplay];
}

- (IBAction)btnCheckAllClicked:(UIButton *)button {
    button.selected = !button.selected;
    _account.checked = button.selected;
    if (_account.transfers) {
        for (Transaction *t in _account.transfers) {
            t.checked = button.selected;
        }
    }
    
    if (_account.batchs) {
        for (Transaction *t in _account.batchs) {
            t.checked = button.selected;
        }
    }
    
    if (_account.others) {
        for (Transaction *t in _account.others) {
            t.checked = button.selected;
        }
    }
    
    if (_delegate) {
        [_delegate didChangeButtonCheckAll:self];
    }
}

- (void)awakeFromNib {
    // Initialization code
}
@end
