//
//  User.m
//  IB Checker
//
//  Created by Thanh on 5/12/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "User.h"


@implementation User

@dynamic authtoken;
@dynamic userName;
@dynamic name;
@dynamic role;
@dynamic activeCode;
@dynamic cifNo;
+ (User *) create: (NSManagedObjectContext *) context {
    return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
}

+ (id)objectFromDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext *)context
{
    User *user;
    if (context) {
        user = [self create:context];
    } else {
        user = [[User alloc] init];
    }
    user.authtoken = [dictionary stringForKey:@"authtoken"];
    user.userName = [dictionary stringForKey:@"userName"];
    user.name = [dictionary stringForKey:@"name"];
    user.cifNo = [[NSNumber alloc] initWithInt:[dictionary intForKey:@"cifNo"]];
    user.role = [[NSNumber alloc] initWithInt:[dictionary intForKey:@"role"]];
    user.activeCode = [dictionary stringForKey:@"activeCode"];
    return user;
}
@end
