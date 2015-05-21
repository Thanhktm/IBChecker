//
//  BaseViewController.m
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark set title for ic toge
- (void)setTitle:(NSString *)title {
    [appDelegate setTitle:title];
}

#pragma mark pushview custom
- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated title:(NSString *)title {
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:title
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    [self.navigationController pushViewController:viewController animated:animated];
}



- (void) startRequest:(BaseService *)service {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void) successRequest:(BaseService *)service response:(NSDictionary *)data {
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) saveContext];
}

- (void) failRequest:(BaseService *)service response:(NSDictionary *)data {

}

- (void) finishRequest:(BaseService *)service {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

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

@end
