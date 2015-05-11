//
//  LoginController.h
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/21/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController<UITextFieldDelegate>{
    
}

@property(nonatomic, assign) BOOL isCheckButton;

- (IBAction)btnCheckLogin:(id)sender;

- (IBAction)btnChangeLanguage:(id)sender;

@end
