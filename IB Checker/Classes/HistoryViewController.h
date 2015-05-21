//
//  HistoryViewController.h
//  IB Checker
//
//  Created by Thanh on 5/20/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseViewController.h"
#import "SlideNavigationController.h"

@class User;

@interface HistoryViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, SlideNavigationControllerDelegate>
@property (nonatomic, strong) User * user;
@end
