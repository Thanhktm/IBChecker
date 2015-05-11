//
//  DataBaseHelper.h
//  IB Checker
//
//  Created by Puganda_Mac on 5/5/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "LoginConfig.h"

@interface DataBaseHelper : NSObject

+(FMDatabase*)getDataBase;
+(void)creatIfNotExitDB;
+(BOOL)insertLoginConfig;
+(BOOL)checkExists;
+(LoginConfig*)getLoginConfig:(int)_id;
+(BOOL)updateLanguage:(int) statusLanguage;

@end
