//
//  HistoryTableViewCell.h
//  IB Checker
//
//  Created by Thanh on 5/20/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Transaction;

@interface HistoryTableViewCell : UITableViewCell
- (void)cellWithData:(Transaction *)transaction;
@property (strong, nonatomic) IBOutlet UILabel *lbInfo;
@property (strong, nonatomic) IBOutlet UILabel *lbAmount;
@property (strong, nonatomic) IBOutlet UIButton *icon;

@property (strong, nonatomic) IBOutlet UILabel *lbDate;
@property (strong, nonatomic) IBOutlet UILabel *lbMessage;
@property (strong, nonatomic) Transaction * transaction;
@end
