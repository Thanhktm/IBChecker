//
//  TransactionResultHeaderView.m
//  IB Checker
//
//  Created by Thanh on 5/19/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "TransactionResultHeaderView.h"

@implementation TransactionResultHeaderView

- (void)awakeFromNib {
    // Initialization code
}

- (void)cellWithData:(NSInteger)number total:(NSInteger)total status:(BOOL)status {
    _btnStatus.selected = status;
    if (status) {
        _lbMessage.text = [NSString stringWithFormat:@"%@ (%d/%d)", NSLocalizedString(@"Success transaction", @""), number, total];
    } else {
        _lbMessage.text = [NSString stringWithFormat:@"%@ (%d/%d)", NSLocalizedString(@"Fail transaction", @""), number, total];
    }
    [self setNeedsDisplay];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
