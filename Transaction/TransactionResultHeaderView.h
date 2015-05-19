//
//  TransactionResultHeaderView.h
//  IB Checker
//
//  Created by Thanh on 5/19/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionResultHeaderView : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbMessage;
@property (strong, nonatomic) IBOutlet UIButton *btnStatus;

- (void)cellWithData:(NSInteger)number total:(NSInteger)total status:(BOOL)status;
@end
