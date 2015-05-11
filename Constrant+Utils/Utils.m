//
//  Utils.m
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/6/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "Utils.h"
#import "Reachability.h"
#import "UrlHelper.h"


@implementation Utils

#pragma mark show message
+ (void)annoucementWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: nil];
    [alert show];
}

+(BOOL)checkStatusNetWork{
    BOOL isCheckNetWork = NO;
    Reachability *myNetwork = [Reachability reachabilityWithHostname:PING_NETWORK];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    
    switch (myStatus) {
        case NotReachable:
            NSLog(@"There's no internet connection at all. Display error message now.");
            isCheckNetWork = NO;
            break;
//        Tam thoi command
//        case ReachableViaWWAN:
//            NSLog(@"We have a 3G connection");
//            break;
//            
//        case ReachableViaWiFi:
//            NSLog(@"We have WiFi.");
//            break;
            
        default:
            isCheckNetWork = YES;
            NSLog(@"We have internet.");
            break;
    }
    
    return isCheckNetWork;
    
//    Reachability * reach = [Reachability reachabilityWithHostname:PING_NETWORK];
//    // Internet is reachable
//    reach.reachableBlock = ^(Reachability*reach)
//    {
//        // Update the UI on the main thread
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"Yayyy, we have the interwebs!");
//        });
//    };
//    
//    // Internet is not reachable
//    reach.unreachableBlock = ^(Reachability*reach)
//    {
//        // Update the UI on the main thread
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"Someone broke the internet :(");
//        });
//    };
//    [reach startNotifier];
}

+(void)switchScreen:(UIViewController*)controller mainView: (UIView*)mainView{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [mainView.window.layer addAnimation:transition forKey:nil];
}

+ (void) showNextView:(UIView*)mainView :(UIView*)targetView{
    targetView.frame = CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.height);
    [mainView addSubview:targetView];
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.2];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[mainView layer] addAnimation:animation forKey:@"SlideView"];
}

@end
