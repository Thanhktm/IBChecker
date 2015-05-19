//
//  Constant.h
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/10/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constant : NSObject


typedef enum {
    CONNECTED,
    CONNECTING,
    DISCONNECTED
} ConnectionState;

extern NSString* const URL_SERVER;
extern NSString* const PING_SERVER;
extern NSString* const MY_TOKEN;


@end
