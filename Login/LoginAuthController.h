//
//  LoginAuthController.h
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/21/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginAuthController : UIViewController<UITextFieldDelegate>

@property(nonatomic, assign) BOOL isCheckButton;

- (IBAction)btnChangeLanguage:(id)sender;

- (IBAction)btnChangeUser:(id)sender;

- (IBAction)btnLogin:(id)sender;

@end
