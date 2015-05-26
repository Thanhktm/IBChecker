//
//  MenuTableViewController.m
//  IB Checker
//
//  Created by Thanh on 5/19/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "MenuTableViewController.h"
#import "User.h"
#import "SlideNavigationController.h"
#import "BaseTableViewController.h"
#import "TransactionsViewController.h"
#import "Constant.h"
#import "TransactionsViewController.h"
#import "HistoryViewController.h"

@interface MenuTableViewController ()
@property (strong, nonatomic) IBOutlet UITableViewCell *cellApprove;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellHistory;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellHelp;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellRating;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellBranch;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellRatingMoney;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;
@property (strong, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (strong, nonatomic) IBOutlet UILabel *lbName;
@property (strong, nonatomic) IBOutlet UILabel *lbCif;
@property (strong, nonatomic) IBOutlet UIButton *btnLock;
@property (strong, nonatomic) NSMutableArray * controlers;


@end

@implementation MenuTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
     NSArray *arrayUser = [self fetchEntity:@"User"];
    if ([arrayUser count] > 0) {
        _user  = [arrayUser objectAtIndex:0];
    }
    if (_user == nil || _user.authtoken == nil) {
        [appDelegate login];
        return;
    }
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back_menu.png"]];

    self.tableView.tableHeaderView = _tableHeaderView;
    
    _lbName.text = _user.name;
    _lbCif.text = [NSString stringWithFormat:@"%@",_user.cifNo];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.bounces = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Buttons Click
- (IBAction)btnLockClicked:(id)sender {
    
    NSFetchRequest * allUsers = [[NSFetchRequest alloc] init];
    [allUsers setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext]];
    [allUsers setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * users = [self.managedObjectContext executeFetchRequest:allUsers error:&error];
    //error handling goes here
    for (NSManagedObject * user in users) {
        [self.managedObjectContext deleteObject:user];
    }
    NSError *saveError = nil;
    [self.managedObjectContext save:&saveError];
    [appDelegate login];
}



#pragma mark Fetch Data
- (NSArray *) fetchEntity: (NSString *)entityName{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSError *error = nil;
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"%@", [error userInfo]);
        return nil;
    }
    
    return results;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
           return _cellApprove;
            break;
        case 1:
            return _cellHistory;
            break;
        case 2:
            return _cellHelp;
            break;
        case 3:
            return _cellRating;
            break;
        case 4:
            return _cellBranch;
            break;
        case 5:
            return _cellRatingMoney;
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    
    UIViewController *nv;
    switch (indexPath.row) {
        case 0:
        {
            if (!_approveViewController) {
                _approveViewController = [[TransactionsViewController alloc] init];
            }
            _approveViewController.user = _user;
            nv = _approveViewController;
        }
            break;
        case 1:
        {
            if (!_historyViewController) {
                _historyViewController = [[HistoryViewController alloc] init];
            }
            _historyViewController.user = _user;
            nv = _historyViewController;
        }
            break;
        default:
        {
            if (!_historyViewController) {
                _historyViewController = [[HistoryViewController alloc] init];
            }
            _historyViewController.user = _user;
            nv = _historyViewController;
        }
            break;
    }
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:nv
                                                             withSlideOutAnimation:YES
                                                                     andCompletion:nil];
}


@end
