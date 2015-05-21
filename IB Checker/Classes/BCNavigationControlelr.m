//
//  BCNavigationControlelr.m
//  IB Checker
//
//  Created by Thanh on 5/20/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BCNavigationControlelr.h"

@interface BCNavigationControlelr ()

@end

@implementation BCNavigationControlelr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)slideNavigationControllerShouldDisplayRightMenu {
    return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}


@end
