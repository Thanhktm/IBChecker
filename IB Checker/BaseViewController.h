//
//  BaseViewController.h
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseService.h"
#import "Item.h"
#import <CoreData/CoreData.h>

@class User;

@interface BaseViewController : UIViewController <ServiceDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) User * user;


- (NSArray *) fetchEntity: (NSString *)entityName;
- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated title:(NSString *)title;
@end
