//
//  AppDelegate.h
//  IB Checker
//
//  Created by Puganda_Mac on 4/24/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatingController.h"
#import "TransactionsViewController.h"
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (strong,nonatomic) WatingController *viewController;
@property (strong,nonatomic) TransactionsViewController *viewController;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

