//
//  MenuTableViewController.h
//  IB Checker
//
//  Created by Thanh on 5/19/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import <CoreData/CoreData.h>
@class TransactionsViewController;
@class BaseViewController;
@class HistoryViewController;

@class User;
@interface MenuTableViewController : UITableViewController <SlideNavigationControllerDelegate>
@property (nonatomic, strong) User * user;
@property (strong, nonatomic) BaseViewController * approveViewController;
@property (strong, nonatomic) BaseViewController * historyViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
