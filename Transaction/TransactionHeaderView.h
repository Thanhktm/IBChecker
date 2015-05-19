//
//  TransactionHeaderView.h
//  IB Checker
//
//  Created by Thanh on 5/16/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Account;
@class TransactionHeaderView;
@protocol TransactionHeaderDelegate <NSObject>
- (void) didChangeButtonCheckAll:(TransactionHeaderView *)header;
- (void) didOutOfMoney;
@end

@interface TransactionHeaderView : UITableViewCell
@property (nonatomic, strong) Account * account;
@property (strong, nonatomic) IBOutlet UILabel *lbSourceAccount;
@property (strong, nonatomic) IBOutlet UILabel *lbAvailableBalance;
@property (strong, nonatomic) IBOutlet UILabel *lbAvailableAfter;
@property (strong, nonatomic) IBOutlet UIButton *btnCheckAll;
@property (strong, nonatomic) IBOutlet UILabel *lblCheckedNumber;

@property (nonatomic, strong) id<TransactionHeaderDelegate> delegate;

- (void)cellWithData:(Account *) account;
@end
