//
//  LoginConfig.h
//  IB Checker
//
//  Created by Puganda_Mac on 5/5/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

@interface LoginConfig : NSObject

@property(nonatomic,strong) NSString * nameCustomer;
@property(nonatomic,assign) int statusRegister;
@property(nonatomic,assign) int statusLogin;
@property(nonatomic,assign) int statusLanguage;


-(id)initWithFMResultSet:(FMResultSet*)rs;

@end
