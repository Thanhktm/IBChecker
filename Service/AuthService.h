//
//  AuthService.h
//  IB Checker
//
//  Created by Thanh on 5/12/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseService.h"
@class User;
@interface AuthService : BaseService
- (void) login:(NSString *)username password:(NSString *) password;

@property (strong) User *user;
@end
