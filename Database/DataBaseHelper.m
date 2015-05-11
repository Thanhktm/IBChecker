//
//  DataBaseHelper.m
//  IB Checker
//
//  Created by Puganda_Mac on 5/5/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "DataBaseHelper.h"
#import "FMDatabase.h"



@implementation DataBaseHelper


+(FMDatabase*)getDataBase{
    NSString* dbTemplatePath = [NSString stringWithFormat:@"%@/Documents/mydbIB.sqlite", NSHomeDirectory()];

    FMDatabase *db = [FMDatabase databaseWithPath:dbTemplatePath];
    return db;
}

+(void)creatIfNotExitDB{
    NSFileManager *fmngr = [[NSFileManager alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"IBChecker" ofType:@"sqlite"];

    NSError *error;
    if(![fmngr copyItemAtPath:filePath toPath:[NSString stringWithFormat:@"%@/Documents/mydbIB.sqlite", NSHomeDirectory()] error:&error]) {
    }
}

+(BOOL)insertLoginConfig{
    FMDatabase *_db = [DataBaseHelper getDataBase];
    BOOL isInsert = NO;
    NSString *insertLoginConfig = @"INSERT INTO config_login(user_name,satus_register,status_login,status_language) VALUES (?,?,?,?)";
    if([_db open]){
        isInsert = [_db executeUpdate:insertLoginConfig,@"",[NSString stringWithFormat:@"%d",1],[NSString stringWithFormat:@"%d",0],[NSString stringWithFormat:@"%d",1]];
    }else{
        NSLog(@"db false to Open insertLoginConfig ");
    }
    [_db close];
    return isInsert;
}

+(BOOL)checkExists{
    BOOL isInsertDB = NO;
    int countTable = 0;
    FMDatabase *_db = [DataBaseHelper getDataBase];
    NSString *strsql = @"select count(*) as num from config_login";
    if ([_db open]) {
        FMResultSet *rs = [_db executeQuery:strsql];
        while ([rs next]) {
            countTable = [rs intForColumn:@"num"];
            if(countTable > 0){
                isInsertDB = YES;
            }else{
                isInsertDB = NO;
            }
        }
    }
    [_db close];
    return isInsertDB;
}

+(LoginConfig*)getLoginConfig:(int)_id{
    FMDatabase *_db = [DataBaseHelper getDataBase];
    if ([_db open]) {
        NSString *strsql = @"select * from config_login where id=?";
        FMResultSet *rs = [_db executeQuery:strsql,[NSString stringWithFormat:@"%d",_id]];
        while ([rs next]) {
            LoginConfig *loginConf = [[LoginConfig alloc]initWithFMResultSet:rs];
            return loginConf;
        }
    }
    [_db close];
    return nil;
}

+(BOOL)updateLanguage:(int) statusLanguage{
    FMDatabase *_db = [DataBaseHelper getDataBase];
    BOOL isUpdated = NO;
    if ([_db open]) {
        NSString *strsql = @"update config_login set status_language=? where id=?";
        isUpdated = [_db executeUpdate:strsql,[NSString stringWithFormat:@"%d",statusLanguage],[NSString stringWithFormat:@"%d",1]];
    }
    [_db close];
    return isUpdated;
}


@end
