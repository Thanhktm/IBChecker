//
//  BaseViewController.m
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
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

- (void) startRequest:(BaseService *)service {

}

- (void) successRequest:(BaseService *)service response:(NSDictionary *)data {
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) saveContext];
}

- (void) failRequest:(BaseService *)service response:(NSDictionary *)data {

}

- (void) finishRequest:(BaseService *)service {

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
