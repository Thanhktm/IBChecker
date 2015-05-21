//
//  BCNavigationControlelr.h
//  IB Checker
//
//  Created by Thanh on 5/20/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import <CoreData/CoreData.h>

@interface BCNavigationControlelr : UINavigationController<SlideNavigationControllerDelegate>

- (NSArray *) fetchEntity: (NSString *)entityName;
@end
