//
//  UserInfo.m
//  IB Checker
//
//  Created by Puganda_Mac on 5/14/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "UserInfo.h"
#import "Constant.h"

@implementation UserInfo


+ (void)setToken:(NSString *)sToken{
    [[NSUserDefaults standardUserDefaults] setObject:sToken forKey:MY_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getToken{
    return [[NSUserDefaults standardUserDefaults] stringForKey:MY_TOKEN];
}

@end
