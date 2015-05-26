//
//  RegisterViewController.m
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/6/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "RegisterViewController.h"
#import "Utils.h"
#import "RegisterService.h"
#import "AuthenViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtRegisterUser;
@property (weak, nonatomic) IBOutlet UITextField *txtRegiterPhone;

@property(strong, nonatomic) RegisterService *registerService;
@property (nonatomic, strong) UITapGestureRecognizer  *tapRecognizer;


@end

@implementation RegisterViewController

@synthesize txtRegisterUser = _txtRegisterUser;
@synthesize txtRegiterPhone = _txtRegiterPhone;
@synthesize tapRecognizer = _tapRecognizer;


- (void)viewDidLoad {
    [super viewDidLoad];
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    // delegate
    [self.view addGestureRecognizer:_tapRecognizer];
    self.txtRegisterUser.delegate = self;
    self.txtRegiterPhone.delegate = self;
    // init  UITextField
    _txtRegisterUser.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _txtRegisterUser.leftViewMode = UITextFieldViewModeAlways;

    _txtRegiterPhone.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _txtRegiterPhone.leftViewMode = UITextFieldViewModeAlways;
    _registerService = [[RegisterService alloc] initWithDelegate:self authtoken:nil];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == _txtRegisterUser) {
        [self.txtRegisterUser resignFirstResponder];
        [self.txtRegiterPhone becomeFirstResponder];
    } else if (theTextField == _txtRegiterPhone) {
        [self.txtRegiterPhone resignFirstResponder];
    }
    return NO;
}


-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [self.txtRegisterUser resignFirstResponder];
    [self.txtRegiterPhone resignFirstResponder];
}

- (IBAction)btnRegisterClick:(id)sender {
    if ((_txtRegisterUser.text == nil) || ([_txtRegisterUser.text isEqualToString:@""])){
        [Utils annoucementWithTitle:nil message:@"Chưa nhập vào tên đăng nhập"];
        [_txtRegisterUser becomeFirstResponder];
        return;
    }
    if ((_txtRegiterPhone.text == nil) || ([_txtRegiterPhone.text isEqualToString:@""])){
        [Utils annoucementWithTitle:nil message:@"Chưa nhập số điện thoại"];
        [_txtRegiterPhone becomeFirstResponder];
        return;
    }
    
    [_registerService registerWithUsername:_txtRegisterUser.text phone:_txtRegiterPhone.text macAddress:@""];

}

#pragma mark - Service Response
-(void)successRequest:(BaseService *)service response:(NSDictionary *)data {
    [_registerService parser:data context:nil];
    AuthenViewController *authenViewController = [[AuthenViewController alloc] init];
    authenViewController.key = _registerService.key;
    [self.navigationController pushViewController:authenViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
