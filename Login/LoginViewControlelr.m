//
//  LoginViewControlelr.m
//  IB Checker
//
//  Created by Thanh on 5/19/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "LoginViewControlelr.h"
#import "AuthService.h"
#import "LoginTextField.h"
#import "TransactionsViewController.h"
#import "Constant.h"
@interface LoginViewControlelr ()
@property (nonatomic, strong) AuthService *authService;

@end

@implementation LoginViewControlelr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _authService = [[AuthService alloc] initWithDelegate:self authtoken:nil];
        [_indicator setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    
    NSArray *arrayUser = [self fetchEntity:@"User"];
    if ([arrayUser count] > 0) {
        TransactionsViewController *transationViewControlelr = [[TransactionsViewController alloc] init];
        transationViewControlelr.managedObjectContext = self.managedObjectContext;
        [self.navigationController pushViewController:transationViewControlelr animated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSignClicked:(id)sender {
    
    if([_txtLogin.text length] > 0 && [_txtPassword.text length] >0) {
        [_authService login:_txtLogin.text password:_txtPassword.text];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Bạn phải điền đủ tên đăng nhập và mật khẩu" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

#pragma mark service delegate

- (void)startRequest:(BaseService *)service {
    [_btnSignIn setEnabled:NO];
    [_indicator startAnimating];
    [_indicator setHidden:NO];
}

- (void)successRequest:(BaseService *)service response:(NSDictionary *)data {
    if ([_authService parser:data context:self.managedObjectContext]) {
        [appDelegate addSlideMenu];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Đăng nhập không thành công thử lại" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        _txtPassword.text  = @"";
        [_txtPassword becomeFirstResponder];
    }
}

- (void)failRequest:(BaseService *)service response:(NSDictionary *)data {
[[[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Đăng nhập không thành công thử lại" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    _txtPassword.text  = @"";
    [_txtPassword becomeFirstResponder];
}

- (void)finishRequest:(BaseService *)service {
    [_btnSignIn setEnabled:YES];
    [_indicator stopAnimating];
    [_indicator setHidden:YES];
}

#pragma mark Textfeild delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _txtLogin) [_txtPassword becomeFirstResponder];
    return YES;
}

@end
