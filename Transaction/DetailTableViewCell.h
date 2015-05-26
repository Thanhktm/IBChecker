//
//  DetailTableViewCell.h
//  IB Checker
//
//  Created by Thanh on 5/25/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbDescription;
@property (strong, nonatomic) IBOutlet UILabel *lbContent;
@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@end
