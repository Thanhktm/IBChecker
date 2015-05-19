//
//  WatingController.m
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/6/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "WatingController.h"
#import "MBProgressHUD.h"
#import "Language.h"
#import "DataBaseHelper.h"
#import "LoginConfig.h"
#import "LoginController.h"
#import "HelpViewController.h"
#import "LoginAuthController.h"
#import "Utils.h"
//#import "NSString+MD5.h"

@interface WatingController ()<MBProgressHUDDelegate>{
    MBProgressHUD *hud;
    int status;
    BOOL isLanguageENG;
}

@end

@implementation WatingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
}


- (void)myProgressTask {
    sleep(3);
    LoginConfig *loginObject = [DataBaseHelper getLoginConfig:1];
//    NSString *result;
//    NSString *decodedString = [NSString stringWithUTF8String:[@"1" cStringUsingEncoding:[NSString defaultCStringEncoding]]];
//    result = [decodedString MD5Hash];
//    NSLog(@" nhay hay ko %@",result);
    if(loginObject != nil){
        if(loginObject.statusLanguage == 1){
            [Language setLanguage:@"vi"];
            isLanguageENG  = NO;
        }else if (loginObject.statusLanguage == 0){
            [Language setLanguage:@"en"];
            isLanguageENG = YES;
        }
        
        if (loginObject.statusRegister == 1) {
            if(loginObject.statusLogin == 1){
                // bang 2 da dang nhap
                status = 2;
            }else if(loginObject.statusLogin == 0){
                // bang 1 da dang ky chua dang nhap
                status = 1;
            }
        }else if(loginObject.statusRegister == 0) {
            // bang 0 chua dang ky
            status = 0;
        }
    }
}

-(void)changeScreen{
    switch (status) {
        case 0:
        {
            HelpViewController *helpController = [[HelpViewController alloc] init];
            [Utils switchScreen:helpController mainView:self.view];
            [self presentViewController:helpController animated:NO completion:nil];
        }
            break;
        case 1:
        {
            LoginController *controller=[[LoginController alloc] init];
            controller.isCheckButton = isLanguageENG;
            [Utils switchScreen:controller mainView:self.view];
            [self presentViewController:controller animated:NO completion:nil];
        }
            break;
        case 2:
        {
            LoginAuthController *controller=[[LoginAuthController alloc] init];
            controller.isCheckButton = isLanguageENG;
            [Utils switchScreen:controller mainView:self.view];
            [self presentViewController:controller animated:NO completion:nil];
        }
            break;
    }
}

-(void)viewDidAppear:(BOOL)animated{
        hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        // Set determinate mode
        hud.userInteractionEnabled = NO;
        hud.delegate = self;
        hud.labelText = [Language get:@"LOADING_HOME"];
    
        [hud showAnimated:YES whileExecutingBlock:^{
            [self myProgressTask];
        } completionBlock:^{
            [hud removeFromSuperview];
            hud = nil;
            [self changeScreen];
        }];
    
//
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
