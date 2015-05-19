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
    _user = [User objectFromDictionary:data context:context];
    return YES;
}

@end
