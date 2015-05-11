//
//  Utils.h
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/6/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

#pragma mark show message
+ (void)annoucementWithTitle:(NSString *)title message:(NSString *)message;
+(BOOL)checkStatusNetWork;
+(void)switchScreen:(UIViewController*)controller mainView: (UIView*)mainView;
+(void)showNextView:(UIView*)mainView :(UIView*)targetView;
@end
