//
//  LoginConfig.m
//  IB Checker
//
//  Created by Puganda_Mac on 5/5/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "LoginConfig.h"
#import "FMResultSet.h"
#import "DataBaseHelper.h"

@implementation LoginConfig

@synthesize nameCustomer = _nameCustomer;
@synthesize statusRegister = _statusRegister;
@synthesize statusLogin = _statusLogin;
@synthesize statusLanguage = _statusLanguage;



-(id)initWithFMResultSet:(FMResultSet*)rs{
    self = [self init];
    if (self) {
        _nameCustomer = [rs stringForColumn:@"user_name"];
        _statusRegister = [rs intForColumn:@"satus_register"];
        _statusLogin = [rs intForColumn:@"status_login"];
        _statusLanguage = [rs intForColumn:@"status_language"];
    }
    return self;
}



@end
