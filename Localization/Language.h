//
//  Language.h
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/7/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Language : NSObject
+(void)initialize;
+(void)setLanguage:(NSString *)l;
+(NSString *)currentLanguage;
//+(NSString *)fullLanguage;  commment
+(NSString *)get:(NSString *)key alter:(NSString *)alternate;
+(NSString *)get:(NSString *)key;
+(int)getCodeTimeout;
@end
