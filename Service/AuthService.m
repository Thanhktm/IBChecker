//
//  AuthService.m
//  IB Checker
//
//  Created by Thanh on 5/12/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "AuthService.h"
#import "User.h"
#import "NSString+MD5.h"

@implementation AuthService

- (void)login:(NSString *)username password:(NSString *)password {
    NSDictionary *params = @{@"userName":username, @"passWord": [password MD5Hash]};
    [self post:@"login" params:params];
}

- (BOOL) parser:(NSDictionary *)data context:(NSManagedObjectContext *) context {
    if (![data valueForKey:@"authtoken"]) {
        return NO;
    }
    NSFetchRequest * allUsers = [[NSFetchRequest alloc] init];
    [allUsers setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
    [allUsers setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * users = [context executeFetchRequest:allUsers error:&error];
    //error handling goes here
    for (NSManagedObject * user in users) {
        [context deleteObject:user];
    }
    NSError *saveError = nil;
    [context save:&saveError];
    _user = [User objectFromDictionary:data context:context];
    return YES;
}

@end
