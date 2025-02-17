//
//  AppDelegate.m
//  IB Checker
//
//  Created by Puganda_Mac on 4/24/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewControlelr.h"
#import "DataBaseHelper.h"
#import "SlideNavigationController.h"
#import "BCNavigationControlelr.h"
#import "MenuTableViewController.h"
#import "TransactionsViewController.h"
#import "User.h"

@interface AppDelegate ()
@property (nonatomic, strong) LoginViewControlelr * loginViewController;
@property (nonatomic, strong) UILabel *lbTitle;
@end

@implementation AppDelegate

- (void)setTitle:(NSString *)title {
    _lbTitle.text = title;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //creat Database if not exit
    [DataBaseHelper creatIfNotExitDB];
    if(![DataBaseHelper checkExists]){
        [DataBaseHelper insertLoginConfig];
    }
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    
    NSArray *users = [self fetchEntity:@"User"];
    if (!_user && [users count] > 0) {
        
        _user = [users objectAtIndex:0];
        if (_user.authtoken) {
            [self addSlideMenu];
        } else {
            [self login];
        }
    } else {
        [self login];
    }
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
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

- (void)addSlideMenu {
    
    NSArray *users = [self fetchEntity:@"User"];
    if (!_user && [users count] > 0) {
        _user = [users objectAtIndex:0];
    }
    MenuTableViewController *menuViewControlelr = [[MenuTableViewController alloc] init];
    menuViewControlelr.managedObjectContext = self.managedObjectContext;
    
    TransactionsViewController  *approveViewController = [[TransactionsViewController alloc] init];
    approveViewController.user = _user;
    
    
    SlideNavigationController *nav = [[SlideNavigationController alloc] initWithRootViewController:approveViewController];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_navigation.png"] forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:                                                   [UIColor whiteColor],NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    [SlideNavigationController sharedInstance].leftMenu = menuViewControlelr;
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    
    // Creating a custom bar button for right menu
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 62, 23)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 4, 30)];
    [button setImage:[UIImage imageNamed:@"ic_menu_toge"] forState:UIControlStateNormal];
    [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    _lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 160, 19)];
    _lbTitle.font = [UIFont systemFontOfSize:19];
    [_lbTitle setTextColor:[UIColor whiteColor]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 190, 19)];
    
    [view addSubview:_lbTitle];
    [view addSubview:button];
    view.bounds = CGRectOffset(view.frame, 10, 0);
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    [SlideNavigationController sharedInstance].leftBarButtonItem = leftBarButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidClose object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Closed %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Opened %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidReveal object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Revealed %@", menu);
    }];
   
    
    self.window.rootViewController = [SlideNavigationController sharedInstance];
}

- (void)login {
    if (!_loginViewController) {
        _loginViewController = [[LoginViewControlelr alloc] init];
        _loginViewController.managedObjectContext = self.managedObjectContext;
    }
    
    self.window.rootViewController = _loginViewController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.feorum.CoreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
