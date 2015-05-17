//
//  Constant.h
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/10/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define appDelegate ((UAAppDelegate *)[[UIApplication sharedApplication] delegate])

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define rgba(r,g,b,a)				[UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define rgb(r,g,b)					rgba(r, g, b, 1.0f)

#ifdef DEBUG
#define log( s, ... ) NSLog( @"<%@:%d> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define log( s, ... )
#endif

#define logBounds(view) UA_log(@"%@ bounds: %@", view, NSStringFromRect([view bounds]))
#define logFrame(view)  UA_log(@"%@ frame: %@", view, NSStringFromRect([view frame]))

@interface Constant : NSObject


typedef enum {
    CONNECTED,
    CONNECTING,
    DISCONNECTED
} ConnectionState;

extern NSString* const URL_SERVER;
extern NSString* const PING_SERVER;


@end
