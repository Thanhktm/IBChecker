//
//  LoginViewControlelr.h
//  IB Checker
//
//  Created by Thanh on 5/19/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseViewController.h"

@class BCTextField;
@interface LoginViewControlelr : BaseViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet BCTextField *txtLogin;
@property (strong, nonatomic) IBOutlet BCTextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end
