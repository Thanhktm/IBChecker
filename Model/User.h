//
//  User.h
//  IB Checker
//
//  Created by Thanh on 5/12/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * authtoken;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * role;
@property (nonatomic, retain) NSString * activeCode;
@property (nonatomic, retain) NSNumber * cifNo;

+ (User *) create: (NSManagedObjectContext *) context;
+ (id)objectFromDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context;

@end
