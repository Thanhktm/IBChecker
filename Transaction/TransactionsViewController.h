//
//  TransactionsViewController.h
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseViewController.h"
#import "TransactionHeaderView.h"
#import "TransactionTableViewCell.h"

@interface TransactionsViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource,
TransactionCellDelegate, TransactionHeaderDelegate, UISearchResultsUpdating, UISearchBarDelegate, UITextFieldDelegate> {


}

@property (nonatomic, strong) UISearchController *searchController;
@end
